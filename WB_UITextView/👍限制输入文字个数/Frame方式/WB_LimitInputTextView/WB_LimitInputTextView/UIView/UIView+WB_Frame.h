//
//  UIView+WB_Frame.h
//  WB_CommonUtility
//
//  Created by WMB on 2017/5/14.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WB_Frame)

#pragma mark -- getter
#pragma mark
/**  最小值x  */
- (CGFloat)wb_left;
/**  最大值x  */
- (CGFloat)wb_right;
/**  view size  */
- (CGSize)wb_size;
/**  最小值y  */
- (CGFloat)wb_top;
/**  最大值y  */
- (CGFloat)wb_bottom;
/**  view 宽度  */
- (CGFloat)wb_width;
/**  view 高度  */
- (CGFloat)wb_height;
/**  中心点 x  */
- (CGFloat)wb_centerX;
/**  中心点 y  */
- (CGFloat)wb_centerY;
/**  x最大值  */
- (CGFloat)wb_maxX;
/**  y最大值  */
- (CGFloat)wb_maxY;
/**  起始点  */
- (CGPoint)wb_origin;

#pragma mark -- setter
#pragma mark
- (void)setWb_left:(CGFloat)wb_left;
- (void)setWb_right:(CGFloat)wb_right;
- (void)setWb_size:(CGSize)wb_size;
- (void)setWb_top:(CGFloat)wb_top;
- (void)setWb_bottom:(CGFloat)wb_bottom;
- (void)setWb_width:(CGFloat)wb_width;
- (void)setWb_height:(CGFloat)wb_height;
- (void)setWb_centerX:(CGFloat)wb_centerX;
- (void)setWb_centerY:(CGFloat)wb_centerY;
- (void)setWb_maxX:(CGFloat)wb_maxX;
- (void)setWb_maxY:(CGFloat)wb_maxY;
- (void)setWb_origin:(CGPoint)wb_origin;

- (void)wb_fill;
@end
