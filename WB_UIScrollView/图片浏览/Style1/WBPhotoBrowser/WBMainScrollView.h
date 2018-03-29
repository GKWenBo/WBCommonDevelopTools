//
//  WB_MainScrollView.h
//  WB_PhotoBrowser
//
//  Created by Admin on 2017/7/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,WBPhotoBrowserType) {
    WBPhotoBrowserLocalType,
    WBPhotoBrowserNetWorkType
};
@protocol WBMainScrollViewDelegate <NSObject>

@optional
/** 关闭PhotoViewer时调用并返回 (观看的最后一张图片的序号) */
- (void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex;
@end
@interface WBMainScrollView : UIScrollView
@property (nonatomic, assign) id<WBMainScrollViewDelegate> myDelegate;

/** 获取数据 */
- (void)setPhotoData:(NSArray *)photoArr type:(WBPhotoBrowserType)type;
@end
