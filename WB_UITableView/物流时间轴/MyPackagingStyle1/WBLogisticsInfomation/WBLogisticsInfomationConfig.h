//
//  WB_LogisticsInfomationConfig.h
//  WB_LogisticsInfomationDemo
//
//  Created by Admin on 2017/7/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#ifndef WB_LogisticsInfomationConfig_h
#define WB_LogisticsInfomationConfig_h

#import "Masonry.h"

/*
 屏幕宽高
 */
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
/**
 自适应大小
 */
#define AUTOLAYOUTSIZE(size) ((size) * (SCREEN_WIDTH / 375))

/*
 设置RGB颜色/设置RGBA颜色
 */
#define RGB_COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA_COLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

static CGFloat const WB_Gap = 10.f;
static CGFloat const WB_LeftSpace = 50.f;
static CGFloat const WB_RightSpace = 10.f;

#endif /* WB_LogisticsInfomationConfig_h */
