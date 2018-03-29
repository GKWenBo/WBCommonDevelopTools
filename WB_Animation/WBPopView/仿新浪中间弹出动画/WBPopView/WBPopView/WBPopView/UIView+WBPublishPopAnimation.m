//
//  UIView+WBPublishPopAnimation.m
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import "UIView+WBPublishPopAnimation.h"

@implementation UIView (WBPublishPopAnimation)

//淡入
- (void)fadeInWithTime:(NSTimeInterval)time{
    self.alpha = 0;
    [UIView animateWithDuration:time animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
//淡出
- (void)fadeOutWithTime:(NSTimeInterval)time{
    self.alpha = 1;
    [UIView animateWithDuration:time animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
//缩放
- (void)scalingWithTime:(NSTimeInterval)time andscal:(CGFloat)scal{
    
    [UIView animateWithDuration:time animations:^{
        self.transform = CGAffineTransformMakeScale(scal,scal);
    }];
}
//旋转
- (void)RevolvingWithTime:(NSTimeInterval)time andDelta:(CGFloat)delta{
    [UIView animateWithDuration:time animations:^{
        self.transform = CGAffineTransformMakeRotation(delta);
    }];
}

@end
