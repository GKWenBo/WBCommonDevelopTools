//
//  WBRoundView.m
//  WB_LoadingIndicatorView
//
//  Created by WMB on 2017/9/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBRoundView.h"

@implementation WBRoundView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (!self.dotViewColor) {
        self.dotViewColor = [UIColor orangeColor];
    }
    [self.dotViewColor set];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    bezierPath.lineCapStyle = kCGLineCapRound; //线条拐角
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [[UIColor orangeColor] setStroke];/**  < 设置描边，需要在[aPath stroke];前面，如果没有的话不显示。并且会不显示线色 >  */
    [bezierPath fill];
}

@end
