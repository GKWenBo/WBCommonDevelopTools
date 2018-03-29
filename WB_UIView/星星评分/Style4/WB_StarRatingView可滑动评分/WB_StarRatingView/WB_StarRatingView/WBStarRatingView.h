//
//  WB_StarRatingView.h
//  WB_StarRatingView
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStarRatingView;
@protocol WB_StarRatingViewDelegate <NSObject>

@optional
- (void)wb_starRatingView:(WBStarRatingView *)wb_starRatingView score:(CGFloat)score;
@end
@interface WBStarRatingView : UIView

@property (nonatomic, assign,readonly) NSInteger numberOfStar;
@property (nonatomic,copy) void (^scoreChangeBlock)(CGFloat score) ;
@property (nonatomic, assign) id<WB_StarRatingViewDelegate> delegate;

/**
 创建评分视图

 @param frame 位置大小
 @param numberOfStar 星星个数
 @return WB_StarRatingView
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfStar:(NSInteger)numberOfStar;

/**
 设置控件分数

 @param score 分数必须在0-1之间
 @param isAnimated 是否启用动画
 */
- (void)setScore:(CGFloat)score isAnimated:(BOOL)isAnimated;


/**
 设置控件分数

 @param score 分数必须在0-1之间
 @param isAnimated 是否启用动画
 @param completion 动画完成block
 */
- (void)setScore:(CGFloat)score isAnimated:(BOOL)isAnimated completion:(void (^) (BOOL isFinished))completion;
@end
