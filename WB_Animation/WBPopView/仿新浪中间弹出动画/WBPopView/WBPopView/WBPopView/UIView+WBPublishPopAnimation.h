//
//  UIView+WBPublishPopAnimation.h
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WBPublishPopAnimation)

//淡入
- (void)fadeInWithTime:(NSTimeInterval)time;
//淡出
- (void)fadeOutWithTime:(NSTimeInterval)time;
//缩放
- (void)scalingWithTime:(NSTimeInterval)time andscal:(CGFloat)scal;
//旋转
- (void)RevolvingWithTime:(NSTimeInterval)time andDelta:(CGFloat)delta;

@end
