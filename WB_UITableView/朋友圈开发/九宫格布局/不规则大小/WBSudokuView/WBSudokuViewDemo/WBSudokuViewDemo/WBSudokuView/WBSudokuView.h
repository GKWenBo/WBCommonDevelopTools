//
//  WBSudokuView.h
//  WBSudokuViewDemo
//
//  Created by Admin on 2017/11/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**  < 格子之间间距 >  */
static CGFloat const kSudokuView_Gap = 5;
/**  < 距离屏幕左右间距 >  */
static CGFloat const kSudokuView_LeftMargin = 15;
static CGFloat const kSudokuView_RightMargin = 15;

@interface WBSudokuView : UIView

/**
 数据源 The resource can be image、imageUrl
 */
@property (nonatomic, strong) NSArray *dataArray;

/**
 计算九宫格视图大小

 @param dataArray 数据源
 @return The size of the view
 */
- (CGSize)calculateSize:(NSArray *)dataArray;

@end
