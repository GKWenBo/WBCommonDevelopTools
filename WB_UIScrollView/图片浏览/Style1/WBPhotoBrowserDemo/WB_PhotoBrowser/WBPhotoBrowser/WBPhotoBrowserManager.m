//
//  WB_PhotoBrowserManager.m
//  WB_PhotoBrowser
//
//  Created by Admin on 2017/7/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBPhotoBrowserManager.h"
#import "WBBrowserPhoto.h"
#import "WBPhotoBrowserConfig.h"
@implementation WBPhotoBrowserManager
+ (instancetype)shareManager {
    return [[WBPhotoBrowserManager alloc]init];
}

- (void)showLocalPhotoBrowserWithOriginImageViews:(NSArray *)imageViews selectedImageIndex:(NSInteger)selectedImageIndex {
    [self setupPhotoData:imageViews selectedImageIndex:selectedImageIndex urlStrArr:nil type:WBPhotoBrowserLocalType];
}

- (void)showNetWorkPhotoBrowserWithOriginImageViews:(NSArray *)imageViews urlStrArr:(NSArray *)urlStrArr selectedImageIndex:(NSInteger)selectedImageIndex {
    [self setupPhotoData:imageViews selectedImageIndex:selectedImageIndex urlStrArr:urlStrArr type:WBPhotoBrowserNetWorkType];
}

#pragma mark -- Private Method
#pragma mark
- (void)setupPhotoData:(NSArray *)imageViews selectedImageIndex:(NSInteger)selectedImageIndex urlStrArr:(NSArray *)urlStrArr type:(WBPhotoBrowserType)type {
    NSMutableArray * photoModelArray = @[].mutableCopy;
    for (NSInteger i = 0; i < imageViews.count; i ++) {
        WBBrowserPhoto *photo = [[WBBrowserPhoto alloc]init];
        UIImageView * imageView = imageViews[i];
        photo.imageView = imageView;
        if (type == WBPhotoBrowserNetWorkType) {
            if (i >= urlStrArr.count || urlStrArr == nil) {
                photo.urlStr = @"";
            }else {
                photo.urlStr = urlStrArr[i];
            }
        }
        if (i == selectedImageIndex) {
            photo.isSelecImageView = YES;
        }else {
            photo.isSelecImageView = NO;
        }
        [photoModelArray addObject:photo];
    }
    WBMainScrollView *mainScroll = [[WBMainScrollView alloc]init];
    mainScroll.myDelegate = self.delegate;
    [mainScroll setPhotoData:photoModelArray type:type];
    [self show:mainScroll];
}

- (void)show:(UIScrollView *)mainScrollView {
    UIView *view = [UIView new];
    view.frame = SCREEN_BOUNDS;
    [view addSubview:mainScrollView];
    NSArray *windowViews = [kKeyWindow subviews];
    if (windowViews && windowViews.count > 0) {
        UIView * subView = [windowViews objectAtIndex:windowViews.count -1];
        for (UIView *aSubView in subView.subviews) {
            [aSubView.layer removeAllAnimations];
        }
        [subView addSubview:view];
    }
}

@end
