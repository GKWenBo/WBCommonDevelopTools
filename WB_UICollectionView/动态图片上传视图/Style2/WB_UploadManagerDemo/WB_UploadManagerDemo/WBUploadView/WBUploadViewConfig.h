//
//  WB_UploadViewConfig.h
//  WB_UploadManagerDemo
//
//  Created by Admin on 2017/7/11.
//  Copyright © 2017年 Admin. All rights reserved.
//

#ifndef WB_UploadViewConfig_h
#define WB_UploadViewConfig_h
//UI Config
static CGFloat const kUpload_Margin = 10;
static CGFloat const kUpload_BigMargin = 15;

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

#if  __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
#define WB_UploadViewSilenceDeprecatedMethodStart()   _Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
#define WB_UploadViewSilenceDeprecatedMethodEnd()     _Pragma("clang diagnostic pop")
#else
#define WB_UploadViewSilenceDeprecatedMethodStart()
#define WB_UploadViewSilenceDeprecatedMethodEnd()
#endif

#import "Masonry.h"
#import "UIView+WBFrame.h"

#endif /* WB_UploadViewConfig_h */
