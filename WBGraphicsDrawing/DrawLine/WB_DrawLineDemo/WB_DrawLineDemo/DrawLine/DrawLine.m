//
//  DrawLine.m
//  WB_DrawLineDemo
//
//  Created by Admin on 2017/9/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "DrawLine.h"

@implementation DrawLine


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(ctx, 6.f);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    CGContextMoveToPoint(ctx, 10, 10);
    CGContextAddLineToPoint(ctx, 10, 60);
    CGContextStrokePath(ctx);
}


@end
