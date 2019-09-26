//
//  SnakePageControl.h
//  Example1
//
//  Created by WenBo on 2019/9/23.
//  Copyright © 2019 wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SnakePageControl : UIView

@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIColor *activeTint;
@property (nonatomic, strong) UIColor *inactiveTint;
@property (nonatomic, assign) CGFloat indicatorPadding;
@property (nonatomic, assign) CGFloat indicatorRadius;
@property (nonatomic, assign) CGFloat indicatorDiameter;
@property (nonatomic, assign) CGFloat progress;

@end

NS_ASSUME_NONNULL_END
