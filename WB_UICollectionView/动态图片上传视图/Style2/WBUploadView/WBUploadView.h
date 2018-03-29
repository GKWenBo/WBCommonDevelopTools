//
//  WB_UploadView.h
//  WB_UploadManagerDemo
//
//  Created by Admin on 2017/7/11.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBUploadView;
@protocol WB_UploadViewDelegate <NSObject>
/** 点击了删除 */
- (void)wb_upLoadView:(WBUploadView *)wb_upLoadView deleteIdx:(NSInteger)deleteIdx;
/** 点击了添加 */
- (void)wb_addCellClicked;
@end
@interface WBUploadView : UIView
@property (nonatomic, strong) NSArray *imageDataArray;          /** 图片数据源 */
@property (strong, nonatomic) NSMutableArray *editedImageArray; /** 编辑过后图片数组 */
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) id<WB_UploadViewDelegate> delegate;


/**
 初始化方法，自定义上传视图样式

 @param frame 大小位置
 @param maxNumRows 最多多少行
 @param rowCount 每行个数
 @param maxCount 最多个数
 @param leftRightMargin 左右间距
 @param topBottomMargin 上下间距
 @param itemSpacing item间距
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame
                   maxNumRows:(NSInteger)maxNumRows
                     rowCount:(NSInteger)rowCount
                     maxCount:(NSInteger)maxCount
              leftRightMargin:(CGFloat)leftRightMargin
              topBottomMargin:(CGFloat)topBottomMargin
                  itemSpacing:(CGFloat)itemSpacing;

@end
