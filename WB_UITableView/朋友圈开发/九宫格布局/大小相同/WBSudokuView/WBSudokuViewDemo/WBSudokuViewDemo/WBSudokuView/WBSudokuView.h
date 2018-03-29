//
//  WBSudokuView.h
//  WBSudokuViewDemo
//
//  Created by WMB on 2017/11/1.
//  Copyright © 2017年 WMB. All rights reserved.
//

/** << 九宫格布局 适用于Masonry布局方式 > */

#import <UIKit/UIKit.h>

/** << 九宫格间隔 > */
static CGFloat const WBSudokuViewGap = 5;
/** << 据左右边距 > */
static CGFloat const WBSudokuViewMargin = 10;
/** << 每行个数 > */
static CGFloat const WBSudokuViewRowCount = 3;

/** << 点击图片下标回调 > */
typedef void(^TapBlock)(NSInteger clickedIndex);

@interface WBSudokuView : UIView

/**
 设置数据源

 @param dataSource 数据源
 @param completeBlock 点击下标回调
 */
- (void)setupSudokuView:(WBSudokuView *)sudokuView dataSource:(NSArray *)dataSource completeBlock:(TapBlock)completeBlock;

/**
 Calculate View Size

 @param dataSource 数据源
 @return CGSize
 */
+ (CGSize)calculateSudokuViewSize:(NSArray *)dataSource;

/**
 单个九宫格宽

 @return 宽
 */
+ (CGFloat)viewWidth;

/**
 单个九宫格高
 
 @return 高
 */
+ (CGFloat)viewHeight;

@end
