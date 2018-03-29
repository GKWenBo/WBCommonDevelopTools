//
//  WBPhoto.h
//  WB_PhotoBrowser
//
//  Created by Admin on 2017/7/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WBBrowserPhoto : NSObject

/** 点进来的小图片ImageView */
@property (nonatomic, strong) UIImageView *imageView;
/** 要显示的网络地址 */
@property (nonatomic, copy) NSString *urlStr;
/** 原图片位置 */
@property (nonatomic, assign) CGRect oldRect;
/** 是不是点进来的ImageView */
@property (nonatomic, assign) BOOL isSelecImageView;
@end
