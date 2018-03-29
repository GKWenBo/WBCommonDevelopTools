//
//  WB_LoadingIndicatorView.h
//  WB_LoadingIndicatorView
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBLoadingIndicatorView : UIView
/**
 cycle fill color default lightGrayColor
 */
@property (nonatomic, strong) UIColor *circleColor;
/**
 cycle speed default 1.0
 */
@property (nonatomic, assign) CGFloat speed;
/**
 cycle numbers default 12 greater than 12
 */
@property (nonatomic, assign) NSInteger numberOfCircleView;
/**
 cycle radius default 1.0 (0 - 1)
 */
@property (nonatomic, assign) CGFloat circleRadius;
/**
 cycle size default 1.0 (0 - 1)
 */
@property (nonatomic, assign) CGFloat circleSize;

- (void)startAnimation;
- (void)stopAnimation;

@end
