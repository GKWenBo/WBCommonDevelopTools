//
//  WBGCDTimerManager.h
//  GCDTimerDemo
//
//  Created by WMB on 2017/11/21.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWBGCDTimerManager [WBGCDTimerManager shareWBGCDTimerManager]

/** <<
 GCD定时器：
 采用单例管理，可用于定时网络请求
 > */

@interface WBGCDTimerManager : NSObject

/**
 Interval default 30s
 */
@property (nonatomic, assign) NSTimeInterval interval;
/**
 Description

 @return WBGCDTimerManager
 */
+ (instancetype)shareWBGCDTimerManager;

/**
 Start timer
 */
- (void)wb_resumeTimer;

/**
 Pause timer
 */
- (void)wb_suspendTimer;

/**
 Cancel Timer
 */
- (void)wb_cancelTimer;

/**
 NetWork
 */
- (void)wb_realTimeRequest;

/**
 程序激活
 */
- (void)wb_applicationDidBecomeActive;
/**
 程序进入后台
 */
- (void)applicationWillResignActive;

@end
