//
//  WBGCDTimerManager.m
//  GCDTimerDemo
//
//  Created by WMB on 2017/11/21.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBGCDTimerManager.h"

static NSInteger i = 0;

@interface WBGCDTimerManager ()

/** << 定时器 > */
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation WBGCDTimerManager

- (void)dealloc {
    NSLog(@"%@销毁了",NSStringFromClass(self.class));
    if (self.timer) {
        [self wb_cancelTimer];
    }
}

+ (instancetype)shareWBGCDTimerManager {
    static WBGCDTimerManager *manager = nil;
    @synchronized(self) {
        if (!manager) {
            manager = [[self alloc]init];
        }
    }
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _interval = 30.0;
        [self createTimer];
    }
    return self;
}

#pragma mark ------ < Create Timer > ------
#pragma mark
- (void)createTimer {
    /** << 创建一个并发队列 > */
    dispatch_queue_t queue = dispatch_queue_create("timer", DISPATCH_QUEUE_CONCURRENT);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    /** << start参数控制计时器第一次触发的时刻 > */
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
//    dispatch_time_t start = dispatch_walltime(NULL, 0);
    /** << 每隔30s执行一次 > */
    uint64_t intaval = (uint64_t)(_interval * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, intaval, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        /** << 任务代码 > */
        NSLog(@"%@",[NSThread currentThread]);
        [self wb_realTimeRequest];
    });
}

- (void)wb_resumeTimer {
    if (self.timer) {
        NSLog(@"定时器开始");
        dispatch_resume(self.timer);
    }
}

- (void)wb_suspendTimer {
    if (self.timer) {
        NSLog(@"定时器暂停");
        dispatch_suspend(self.timer);
    }
}

- (void)wb_cancelTimer {
    if (self.timer) {
        NSLog(@"定时器销毁");
        dispatch_source_cancel(self.timer);
    }
}

- (void)wb_realTimeRequest {
    i++;
    NSLog(@"%ld",i);
}

- (void)wb_applicationDidBecomeActive {
    [self wb_resumeTimer];
}

- (void)applicationWillResignActive {
    [self wb_suspendTimer];
}

@end
