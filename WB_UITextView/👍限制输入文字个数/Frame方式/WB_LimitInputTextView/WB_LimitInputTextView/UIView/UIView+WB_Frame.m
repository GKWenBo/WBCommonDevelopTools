//
//  UIView+WB_Frame.m
//  WB_CommonUtility
//
//  Created by WMB on 2017/5/14.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "UIView+WB_Frame.h"

@implementation UIView (WB_Frame)
- (CGFloat)wb_left {
    return self.frame.origin.x;
}
- (CGFloat)wb_right {
    return self.frame.origin.x + self.frame.size.width;
}
- (CGFloat)wb_top {
    return self.frame.origin.y;
}
- (CGFloat)wb_bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (CGSize)wb_size {
    return self.frame.size;
}
- (CGFloat)wb_width {
    return self.frame.size.width;
}
- (CGFloat)wb_height {
    return self.frame.size.height;
}
- (CGFloat)wb_centerX {
    return self.center.x;
}
- (CGFloat)wb_centerY {
    return self.center.y;
}
- (CGFloat)wb_maxX {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)wb_maxY {
    return CGRectGetMaxY(self.frame);
}
- (CGPoint)wb_origin {
    return self.frame.origin;
}

#pragma mark -- setter
#pragma mark
- (void)setWb_left:(CGFloat)wb_left {
    CGRect frame = self.frame;
    frame.origin.x = wb_left;
    self.frame = frame;
}
- (void)setWb_right:(CGFloat)wb_right {
    CGRect frame = self.frame;
    frame.origin.x = wb_right - frame.size.width;
    self.frame = frame;
}
- (void)setWb_size:(CGSize)wb_size {
    CGRect frame = self.frame;
    frame.size = wb_size;
    self.frame = frame;
}
- (void)setWb_top:(CGFloat)wb_top {
    CGRect frame = self.frame;
    frame.origin.y = wb_top;
    self.frame = frame;
}
- (void)setWb_bottom:(CGFloat)wb_bottom {
    CGRect frame = self.frame;
    frame.origin.y = wb_bottom - frame.size.height;
    self.frame = frame;
}
- (void)setWb_width:(CGFloat)wb_width {
    CGRect frame = self.frame;
    frame.size.width = wb_width;
    self.frame = frame;
}
- (void)setWb_height:(CGFloat)wb_height {
    CGRect frame = self.frame;
    frame.size.height = wb_height;
    self.frame = frame;
}
- (void)setWb_centerX:(CGFloat)wb_centerX {
    self.center = CGPointMake(wb_centerX, self.center.y);
}
- (void)setWb_centerY:(CGFloat)wb_centerY {
    self.center = CGPointMake(self.center.x, wb_centerY);
}
- (void)setWb_maxX:(CGFloat)wb_maxX {
    CGRect frame = self.frame;
    frame.origin.x = wb_maxX - frame.size.width;
    self.frame = frame;
}
- (void)setWb_maxY:(CGFloat)wb_maxY {
    CGRect frame = self.frame;
    frame.origin.y = wb_maxY - frame.size.height;
    self.frame = frame;
}
- (void)setWb_origin:(CGPoint)wb_origin {
    CGRect frame = self.frame;
    frame.origin = wb_origin;
    self.frame = frame;
}

- (void)wb_fill {
    self.frame = CGRectMake(0, 0, self.superview.wb_width, self.superview.wb_height);
}
@end
