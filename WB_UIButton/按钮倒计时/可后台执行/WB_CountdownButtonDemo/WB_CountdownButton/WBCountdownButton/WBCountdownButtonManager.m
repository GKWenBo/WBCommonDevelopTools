//
//  WB_CountdownButtonManager.m
//  WB_CountdownButton
//
//  Created by WMB on 2017/6/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBCountdownButtonManager.h"
#import <UIKit/UIKit.h>

@interface WB_CountdownTask : NSOperation

/**
 *  计时中回调
 */
@property (copy, nonatomic) void (^countingDownBlcok)(NSTimeInterval timeInterval);
/**
 *  计时结束后回调
 */
@property (copy, nonatomic) void (^finishedBlcok)(NSTimeInterval timeInterval);
/**
 *  计时剩余时间
 */
@property (assign, nonatomic) NSTimeInterval leftTimeInterval;
/**
 *  后台任务标识，确保程序进入后台依然能够计时
 */
@property (assign, nonatomic) UIBackgroundTaskIdentifier taskIdentifier;

/**
 *  `NSOperation`的`name`属性只在iOS8+中存在，这里定义一个属性，用来兼容 iOS7
 */
@property (copy, nonatomic) NSString *operationName;

@end


@implementation WB_CountdownTask

- (void)dealloc {
    _countingDownBlcok = nil;
    _finishedBlcok     = nil;
}

- (void)main {
    self.taskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    
    while (--_leftTimeInterval > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_countingDownBlcok) _countingDownBlcok(_leftTimeInterval);
        });
        
        [NSThread sleepForTimeInterval:1];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_finishedBlcok) {
            _finishedBlcok(0);
        }
    });
    
    
    if (self.taskIdentifier != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:self.taskIdentifier];
        self.taskIdentifier = UIBackgroundTaskInvalid;
    }
}

@end


@interface WBCountdownButtonManager ()

@property (nonatomic,strong) NSOperationQueue * pool;

@end

@implementation WBCountdownButtonManager

#pragma mark --------  初始化  --------
#pragma mark
+ (instancetype)shareManager {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self _alloc] _init];
    });
    
    if ([instance class] != [WBCountdownButtonManager class]) {
        NSCAssert(NO, @"该类不允许被继承");
    }
    
    return instance;
}

+ (instancetype)alloc {
    NSCAssert(NO, @"请使用`+defaultManager`方法获取实例");
    return nil;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    NSCAssert(NO, @"请使用`+defaultManager`方法获取实例");
    return nil;
}

+ (instancetype)_alloc {
    return [super allocWithZone:NSDefaultMallocZone()];
}

- (instancetype)init {
    NSCAssert(NO, @"请使用`+defaultManager`方法获取实例");
    return nil;
}

- (instancetype)_init {
    if (self = [super init]) {
        _pool = [[NSOperationQueue alloc] init];
    }
    
    return self;
}

#pragma mark --------  方法  --------
#pragma mark
- (void)scheduledCountDownWithKey:(NSString *)aKey timeInterval:(NSTimeInterval)timeInterval countingDown:(void (^)(NSTimeInterval))countingDown finished:(void (^)(NSTimeInterval))finished {
    
    if (timeInterval > 120) {
        NSCAssert(NO, @"受操作系统后台时间限制，倒计时时间规定不得大于 120 秒.");
    }
    
    if (_pool.operations.count >= 20)  // 最多 20 个并发线程
        return;
    
    WB_CountdownTask *task = nil;
    if ([self countdownTaskExistWithKey:aKey task:&task]) {
        task.countingDownBlcok = countingDown;
        task.finishedBlcok     = finished;
        if (countingDown) {
            countingDown(task.leftTimeInterval);
        }
    } else {
        task                   = [[WB_CountdownTask alloc] init];
        task.leftTimeInterval  = timeInterval;
        task.countingDownBlcok = countingDown;
        task.finishedBlcok     = finished;
        
        if ([@([UIDevice currentDevice].systemVersion.doubleValue) compare:@(8)] == NSOrderedAscending) {
            task.operationName = aKey;
        }
        else {
            task.name = aKey;
        }
        
        [_pool addOperation:task];
    }    
}

- (BOOL)countdownTaskExistWithKey:(NSString *)akey task:(WB_CountdownTask *__autoreleasing  _Nullable *)task {
    
    __block BOOL taskExist = NO;
    
    if ([@([UIDevice currentDevice].systemVersion.doubleValue) compare:@(8)] == NSOrderedAscending) {
        [_pool.operations enumerateObjectsUsingBlock:^(__kindof WB_CountdownTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.operationName isEqualToString:akey]) {
                if (task) *task = obj;
                taskExist = YES;
                *stop     = YES;
            }
        }];
    }
    else {
        [_pool.operations enumerateObjectsUsingBlock:^(__kindof WB_CountdownTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.name isEqualToString:akey]) {
                if (task) *task = obj;
                taskExist = YES;
                *stop     = YES;
            }
        }];
    }
    
    return taskExist;

}

@end
