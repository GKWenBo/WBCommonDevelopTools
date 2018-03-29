//
//  ViewController.m
//  NSTimerDemo
//
//  Created by Admin on 2017/11/20.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
static NSInteger i = 0;
@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTimer];
}

//创建定时器
- (void)createTimer {
    /**  < 第一种创建方法 需手动加入RunLoop timer才会执行 >  */
//    self.timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(printSeconds) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    /**  < 第二种创建方法 自动加入RunLoop >  */
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(printSeconds) userInfo:nil repeats:YES];
    

}

- (void)printSeconds {
    NSLog(@"%ld",i);
    i++;
}

//销毁定时器
- (void)clearTimer {
    [self.timer invalidate];
    self.timer = nil;
    
}
- (IBAction)start:(id)sender {
    /**  < 开始定时器 >  */
    if (self.timer.isValid) {
        self.timer.fireDate = [NSDate date];
    }
}

- (IBAction)pause:(id)sender {
    /**  < 暂停定时器 >  */
    if (self.timer.isValid) {
        self.timer.fireDate = [NSDate distantFuture];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clear:(id)sender {
    [self clearTimer];
}

#pragma mark ------ < Getter > ------
#pragma mark


@end
