//
//  HollowCircle.m
//  WB_CircleDemo
//
//  Created by Admin on 2017/9/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "HollowCircle.h"

@implementation HollowCircle

#pragma mark -- 视图初始化
#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initData];
    }
    return self;
}

#pragma mark -- 初始化数据
#pragma mark
- (void)initData {
    _hollowCircleColor = [UIColor orangeColor];
    _hollowCircleWidth = 2;
    _solidCircleColor = [UIColor redColor];
    _spacing = 1;
}


#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef hollowCtx = UIGraphicsGetCurrentContext();
    CGContextRef solidCtx = UIGraphicsGetCurrentContext();
    CGRect bigRect = CGRectMake(rect.origin.x + _hollowCircleWidth / 2, rect.origin.y + _hollowCircleWidth / 2, rect.size.width - _hollowCircleWidth, rect.size.height - _hollowCircleWidth);
    CGRect smallRect = CGRectMake(bigRect.origin.x + _hollowCircleWidth / 2 + _spacing, bigRect.origin.y + _spacing + _hollowCircleWidth / 2, rect.size.width - _hollowCircleWidth * 2 - _spacing * 2, rect.size.height - _hollowCircleWidth * 2 - _spacing * 2);
    /**  < 画实心圆 >  */
    /**  < 填充当前矩形区域 >  */
    [[UIColor whiteColor] set];
    CGContextFillRect(solidCtx, smallRect);
    /**  < 以矩形frame为依据画一个圆 >  */
    CGContextAddEllipseInRect(solidCtx, smallRect);
    /**  < 填充当前绘画区域内的颜色 >  */
    [_solidCircleColor set];
    /**  < 填充(沿着矩形内围填充出指定大小的圆) >  */
    CGContextFillPath(solidCtx);
    
    /**  < 画空心圆 >  */
    /**  < 设置空心圆的线条宽度 >  */
    CGContextSetLineWidth(hollowCtx, _hollowCircleWidth);
    /**  < 以矩形bigRect为依据画一个圆 >  */
    CGContextAddEllipseInRect(hollowCtx, bigRect);
    /**  < 填充当前绘画区域的颜色 >  */
    [_hollowCircleColor set];
    /**  < (如果是画圆会沿着矩形外围描画出指定宽度的（圆线）空心圆)/（根据上下文的内容渲染图层） >  */
    CGContextStrokePath(hollowCtx);
}

#pragma mark -- #pragma mark -- Getter And Setter
#pragma mark
- (void)setHollowCircleColor:(UIColor *)hollowCircleColor {
    _hollowCircleColor = hollowCircleColor;
    [self setNeedsDisplay];
}

- (void)setHollowCircleWidth:(CGFloat)hollowCircleWidth {
    _hollowCircleWidth = hollowCircleWidth;
    [self setNeedsDisplay];
}

- (void)setSolidCircleColor:(UIColor *)solidCircleColor {
    _solidCircleColor = solidCircleColor;
    [self setNeedsDisplay];
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
    [self setNeedsDisplay];
}

@end
