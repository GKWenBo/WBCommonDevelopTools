//
//  HollowCircle.h
//  WB_CircleDemo
//
//  Created by Admin on 2017/9/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HollowCircle : UIView

/**
 The width of the hollowCircle default is 2
 */
@property (nonatomic, assign) CGFloat hollowCircleWidth;

/**
 The color of the hollowCircle default is orangeColor
 */
@property (nonatomic, strong) UIColor *hollowCircleColor;

/**
 The spacing between hollowCircle and solidCircle default is 1
 */
@property (nonatomic, assign) CGFloat spacing;

/**
 The color of the solidCircle default is redColor
 */
@property (nonatomic, strong) UIColor *solidCircleColor;

@end
