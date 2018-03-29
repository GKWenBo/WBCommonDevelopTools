//
//  WB_PhotoBrowserConfig.h
//  WB_PhotoBrowser
//
//  Created by Admin on 2017/7/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#ifndef WB_PhotoBrowserConfig_h
#define WB_PhotoBrowserConfig_h
#import "SDProgressView.h"
#import "UIImageView+WebCache.h"
#import "UIView+WBFrame.h"
/*
 屏幕宽高
 */
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

#define kKeyWindow [UIApplication sharedApplication].keyWindow

#define kDelegateWindow [[[UIApplication sharedApplication] delegate] window]

#define kAnimationInterval 0.4f
#define kGap 10.f

#endif /* WB_PhotoBrowserConfig_h */
