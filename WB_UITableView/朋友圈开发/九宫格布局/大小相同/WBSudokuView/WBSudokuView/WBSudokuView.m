//
//  WBSudokuView.m
//  WBSudokuViewDemo
//
//  Created by WMB on 2017/11/1.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBSudokuView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#define kImageViewTag 9999

@implementation WBSudokuView
{
    /** << 数据源 > */
    NSArray *_dataSource;
    TapBlock _tapBlock;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark ------ < 设置数据源 > ------
#pragma mark
- (void)setupSudokuView:(WBSudokuView *)sudokuView dataSource:(NSArray *)dataSource completeBlock:(TapBlock)completeBlock {
    /** << 解决复用问题 > */
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _dataSource = dataSource;
    _tapBlock = completeBlock;
    [_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = [UIColor orangeColor];
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *urlString = (NSString *)obj;
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@""]];
        }else if ([obj isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)obj;
            imageView.image = image;
        }else if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
        }
        imageView.tag = idx + kImageViewTag;
        [self addSubview:imageView];
        
        CGFloat X = (([WBSudokuView viewWidth] + WBSudokuViewGap)) * (idx % 3);
        CGFloat Y = floorf(idx / 3) * ([WBSudokuView viewHeight] + WBSudokuViewGap);
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(sudokuView).offset(X);
            make.top.mas_equalTo(sudokuView).offset(Y);
            make.size.mas_equalTo(CGSizeMake([WBSudokuView viewWidth], [WBSudokuView viewHeight]));
        }];
        /** << 添加点击事件 > */
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:sudokuView action:@selector(singleTap:)];
        [imageView addGestureRecognizer:singleTap];
    }];
}

#pragma mark ------ < Event Response > ------
#pragma mark
- (void)singleTap:(UITapGestureRecognizer *)sender {
    NSInteger tag = sender.view.tag - kImageViewTag;
    if (_tapBlock) {
        _tapBlock(tag);
    }
    /** << 这里可以添加图片游览代码 > */
}

#pragma mark ------ < 计算九宫格Size > ------
#pragma mark
+ (CGSize)calculateSudokuViewSize:(NSArray *)dataSource {
    if(dataSource.count == 0) {
        return CGSizeZero;
    }
    CGFloat width = 0.f;
    CGFloat height = 0.f;
    NSInteger count = dataSource.count;
    if (count > 0 && count <= 3) {
        height = [self viewHeight];
        width = count *  ([self viewWidth] + WBSudokuViewGap) - WBSudokuViewGap;
    }else if (count > 3 && count <= 6) {
        height = 2 * ([self viewHeight] + WBSudokuViewGap) - WBSudokuViewGap;
        width = 3 * ([self viewWidth] + WBSudokuViewGap) - WBSudokuViewGap;
    }else if (count > 6 && count <= 9) {
        height = 3 * ([self viewHeight] + WBSudokuViewGap) - WBSudokuViewGap;
        width = 3 * ([self viewWidth] + WBSudokuViewGap) - WBSudokuViewGap;
    }
    return CGSizeMake(width, height);
}

+ (CGFloat)viewWidth {
    return ([UIScreen mainScreen].bounds.size.width - 2 * (WBSudokuViewMargin + WBSudokuViewGap)) / WBSudokuViewRowCount;
}

+ (CGFloat)viewHeight {
    return ([UIScreen mainScreen].bounds.size.width - 2 * (WBSudokuViewMargin + WBSudokuViewGap)) / WBSudokuViewRowCount;
}

@end
