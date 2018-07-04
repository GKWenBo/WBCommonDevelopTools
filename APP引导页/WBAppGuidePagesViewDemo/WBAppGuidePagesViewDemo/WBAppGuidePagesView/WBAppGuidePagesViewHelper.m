//
//  WBAppGuidePagesViewHelper.m
//  WBAppGuidePagesViewDemo
//
//  Created by wenbo on 2018/5/14.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "WBAppGuidePagesViewHelper.h"
#import "WBAppGuidePagesView.h"

@interface WBAppGuidePagesViewHelper ()

@property (nonatomic, strong) WBAppGuidePagesView *pageView;
@property (nonatomic, weak) UIWindow *currentWindow;

@end

static WBAppGuidePagesViewHelper *instance = nil;
@implementation WBAppGuidePagesViewHelper

+ (instancetype)shareHelper {
    if (!instance) {
        instance = [[self alloc]init];
    }
    return instance;
}

- (void)wb_showGuidePagesViewWithDataArray:(NSArray<NSString *> *)images {
    if (images.count == 0) return;
    if (![WBAppGuidePagesViewHelper shareHelper].pageView) {
        [WBAppGuidePagesViewHelper shareHelper].pageView = [WBAppGuidePagesView wb_pagesViewWithFrame:[UIScreen mainScreen].bounds
                                                                                               images:images];
    }
    [WBAppGuidePagesViewHelper shareHelper].currentWindow = [UIApplication sharedApplication].keyWindow;
    [[WBAppGuidePagesViewHelper shareHelper].currentWindow addSubview:[WBAppGuidePagesViewHelper shareHelper].pageView];
}

@end
