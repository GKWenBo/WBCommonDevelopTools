//
//  WB_StarRatingView.h
//  WB_StarRatingView
//
//  Created by Admin on 2017/7/25.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CurrentScoreChangeBlock)(CGFloat score);
typedef NS_ENUM(NSInteger,WBStarRateStyle) {
    WBStarRateWholeStyle,       /** 整星 */
    WBStarRateHalfStyle,        /** 半颗星星 */
    WBStarRateUnlimitedStyle    /** 无限制 */
};
@interface WBStarRatingView : UIView

/** 间距 初始化后设置 默认5.0 */
@property (nonatomic, assign) CGFloat spacing;
/** 选中星星图片 */
@property (nonatomic, strong) NSString *checkedImageName;
/** 未选中图片 */
@property (nonatomic, strong) NSString *unCheckedImageName;
/** 最大分数 默认5.0 */
@property (nonatomic, assign) CGFloat maxLimitScore;
/** 最小分数 默认0.0 */
@property (nonatomic, assign) CGFloat minLimitScore;
/** 启用点击 默认NO */
@property (nonatomic, assign) BOOL touchEnabled;
/** 启用滑动 默认NO */
@property (nonatomic, assign) BOOL slideEnabled;
/** 评分类型 默认整星*/
@property (nonatomic, assign) WBStarRateStyle rateStyle;
/** 当前分数 (以上设置完毕后 , 再设置 , 默认 0.0) */
@property (nonatomic, assign) CGFloat currentScore;
/** 分数变更Block */
@property (nonatomic,copy) CurrentScoreChangeBlock scoreBlock;
/**
 初始化视图

 @param frame frame description
 @param numberOfStars 星星个数
 @return starView
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

@end
