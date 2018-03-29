//
//  SolidCircle.m
//  WB_CircleDemo
//
//  Created by Admin on 2017/9/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "SolidCircle.h"

@implementation SolidCircle


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // Drawing code
    /**  < 获取上下文 >  */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat width = rect.size.width;
    /**  < 画实心圆 >  */
    CGRect frame = CGRectMake(0, 0, width, width);
    /**  < 填充当前绘画区域内的颜色 >  */
    if (!self.circleColor) {
        self.circleColor = [UIColor redColor];
    }
    [[UIColor whiteColor] set];
    /**  < 填充当前矩形区域 >  */
    CGContextFillRect(ctx, rect);
    /**  < 以矩形frame为依据画一个圆 >  */
    CGContextAddEllipseInRect(ctx, frame);
    /**  < 填充当前绘画区域内的颜色 >  */
    [self.circleColor set];
    /**  < 填充(沿着矩形内围填充出指定大小的圆) >  */
    CGContextFillPath(ctx);
}


@end
