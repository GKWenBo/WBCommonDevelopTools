//
//  WB_PhotoBrowserManager.h
//  WB_PhotoBrowser
//
//  Created by Admin on 2017/7/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBMainScrollView.h"
#define kWBPhotoBrowser [WBPhotoBrowserManager shareManager]
@interface WBPhotoBrowserManager : NSObject

+ (instancetype)shareManager;
@property (nonatomic, assign) id<WBMainScrollViewDelegate> delegate;

- (void)showLocalPhotoBrowserWithOriginImageViews:(NSArray *)imageViews selectedImageIndex:(NSInteger)selectedImageIndex;
- (void)showNetWorkPhotoBrowserWithOriginImageViews:(NSArray *)imageViews urlStrArr:(NSArray *)urlStrArr selectedImageIndex:(NSInteger)selectedImageIndex;
@end
