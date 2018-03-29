//
//  WBSudokuView.m
//  WBSudokuViewDemo
//
//  Created by Admin on 2017/11/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBSudokuView.h"

@implementation WBSudokuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma mark ------ < 计算大小 > ------
#pragma mark
- (CGSize)calculateSize:(NSArray *)dataArray {
    CGFloat viewWidth = 0.f;
    CGFloat viewHeight = 0.f;
    NSInteger count = dataArray.count;
    NSInteger perRowItemCount = [self perRowItemCountForPicPathArray:dataArray];
    if(count == 0) {
        viewWidth = 0.f;
        viewHeight = 0.f;
    }else if (count == 1) {
        /**  < 计算一张图片size >  */
        id object = dataArray.firstObject;
        viewWidth = [self itemWidthForPicPathArray:dataArray];
        viewHeight = [self calculateOnePicHeight:object itemWidth:viewWidth];
    }else if (count == 2 || count == 4) {
        /**  < 计算2&4张图片size >  */
        CGFloat itemW = [self itemWidthForPicPathArray:dataArray];
        NSInteger row = ceilf(count / perRowItemCount);
        viewWidth = row * (itemW + kSudokuView_Gap) - kSudokuView_Gap;
        viewHeight = viewWidth;
    }else {
        CGFloat itemW = [self itemWidthForPicPathArray:dataArray];
        NSInteger row = ceilf(count / perRowItemCount);
        if (row == 1) {
            viewHeight =  row *itemW;
        }else {
            viewHeight = row * (itemW + kSudokuView_Gap) - kSudokuView_Gap;
        }
        viewWidth = perRowItemCount * (itemW + kSudokuView_Gap) - kSudokuView_Gap;
    }
    return CGSizeMake(viewWidth, viewHeight);
}

/**
 每行格子个数

 @param array 数据源
 @return 每行个数
 */
- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count == 4 || array.count == 2) {
        return 2;
    } else {
        return 3;
    }
}

/**
 格子宽度

 @param array 数据源
 @return width
 */
- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    CGFloat width = 0.f;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    if (array.count == 1) {
       width = screen_width * 0.375;
    }else if (array.count == 4 || array.count == 2) {
        width = (screen_width - kSudokuView_LeftMargin - kSudokuView_RightMargin - kSudokuView_Gap) / 2;
    }else {
        width = (screen_width - kSudokuView_LeftMargin - kSudokuView_LeftMargin - 2 * kSudokuView_Gap) / 3;
    }
    return width;
}

- (CGFloat)calculateOnePicHeight:(id)object itemWidth:(CGFloat)itemWidth {
    CGFloat height = 0.f;
    if ([object isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage *)object;
        if (image.size.width) {
            height = image.size.height / image.size.width * itemWidth;
        }
    }else if ([object isKindOfClass:[NSString class]]) {
        UIImage *image = [UIImage imageNamed:(NSString *)object];
        if (image.size.width) {
            height = image.size.height * (itemWidth / image.size.width);
        }
    }
    return height;
}

#pragma mark ------ < Setter > ------
#pragma mark
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    if (dataArray.count == 0) {
        return;
    }
    /**  < 循环创建图片视图 >  */
    __weak typeof(self) weakSelf = self;
    NSInteger count = dataArray.count;
    NSInteger perRowCount = [self perRowItemCountForPicPathArray:dataArray];
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        /**  < 创建图片视图 >  */
        UIImageView *imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        if ([obj isKindOfClass:[NSString class]]) {
            UIImage *image = [UIImage imageNamed:(NSString *)obj];
            imageView.image = image;
        }
        /**  < 布局 >  */
        CGRect frame;
        CGFloat x,y,itemW,itemH;
        NSInteger row = ceilf(idx / perRowCount);
        NSInteger column = idx % perRowCount;
        if (count == 1) {
            x = 0;
            y = 0;
            itemW = [weakSelf itemWidthForPicPathArray:dataArray];
            itemH = [weakSelf calculateOnePicHeight:dataArray.firstObject itemWidth:itemW];
            frame = CGRectMake(x, y, itemW, itemH);
        }else {
            itemW = [weakSelf itemWidthForPicPathArray:dataArray];
            itemH = itemW;
            x = column * (itemW + kSudokuView_Gap);
            y = row  * (itemH + kSudokuView_Gap);
            frame = CGRectMake(x, y, itemW, itemH);
        }
        imageView.frame = frame;
        imageView.backgroundColor = [UIColor orangeColor];
        [weakSelf addSubview:imageView];
    }];
}

@end
