//
//  WB_StarRatingView.h
//  WB_StarRatingView
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStarRatingView;
typedef NS_ENUM(NSInteger,WBStarRateStyle) {
    WBStarRateWholeStyle,
    WBStarRateHalfStyle,
    WBStarRateIncompleteStyle
};
@protocol WB_StarRatingViewDelegate <NSObject>

@optional
- (void)wb_starRatingView:(WBStarRatingView *)wb_starRatingView scoreDidChange:(CGFloat)score;

@end

@interface WBStarRatingView : UIView
/** 得分值，范围为0--1，默认为1 */
@property (nonatomic, assign) CGFloat currentScore;
//@property (nonatomic, assign) BOOL allowIncompleteStar;
/** 评分样式 默认是整星 */
@property (nonatomic, assign) WBStarRateStyle style;
/** 是否允许动画，默认为NO */
@property (nonatomic, assign) BOOL hasAnimation;
/** 分数回调 */
@property (nonatomic,copy) void (^scoreChangeBlock)(CGFloat score) ;
@property (nonatomic, assign) id<WB_StarRatingViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

@end
