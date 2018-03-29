//
//  WB_OneScrollView.h
//  WB_PhotoBrowser
//
//  Created by Admin on 2017/7/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WBOneScrollViewDelegate <NSObject>

- (void)goBack;
- (void)willGoBack:(NSInteger)seletedIndex;
@end

@interface WBOneScrollView : UIScrollView

@property (nonatomic, assign) NSInteger myindex;
@property (nonatomic, assign) id<WBOneScrollViewDelegate>myDelegate;

/** 加载本地图片 */
- (void)setLocalImage:(UIImageView *)imageView;
/** 网络图片加载 */
- (void)setNetWorkImage:(UIImageView *)imageView urlStr:(NSString *)urlStr;
/** 回复放大缩小前的原状 */
- (void)reloadFrame;
@end
