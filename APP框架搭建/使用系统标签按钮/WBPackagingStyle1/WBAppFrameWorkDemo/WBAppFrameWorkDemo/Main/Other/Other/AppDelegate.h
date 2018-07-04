//
//  AppDelegate.h
//  WBAppFrameWorkDemo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/** << 进入登录界面 > */
- (void)wb_enterLoginVc;
/** << 进入便签控制器 > */
- (void)wb_enterMainVc;

@end

