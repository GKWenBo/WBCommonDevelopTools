//
//  WB_FiveStarRatingView.h
//  WB_FiveStarRatingView
//
//  Created by Admin on 2017/7/21.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WBScoreBlock)(NSNumber *scoreNumber);
@class WBFiveStarRatingView;
typedef WBFiveStarRatingView *(^WBFrameChain)(CGPoint point,float size);
typedef WBFiveStarRatingView *(^WBNeedIntValueChain)(BOOL needIntValue);
typedef WBFiveStarRatingView *(^WBCanTouchChain)(BOOL canTouch);
typedef WBFiveStarRatingView *(^WBScoreBlockChain)(WBScoreBlock scroreBlock);
typedef WBFiveStarRatingView *(^WBScoreNumChain)(NSNumber *scoreNum);
typedef WBFiveStarRatingView *(^WBSuperViewChain)(UIView *superView);
typedef WBFiveStarRatingView *(^WBColorChain)(UIColor *color);
@interface WBFiveStarRatingView : UIView

/**
 链式调用

 @return WB_FiveStarRatingView
 */
+ (instancetype)init;

/**
 *  设置point和size   传值 : frameChain(CGPoint,float)
 */
@property (nonatomic, copy, readonly) WBFrameChain frameChain;

/**
 *  分数是否显示为整数 如果为yes星星都是整个整个显示   needIntValueChain(BOOL)
 */
@property (nonatomic, copy, readonly) WBNeedIntValueChain needIntValueChain;

/**
 *  默认为NO  星星是否可以点击   canTouchChain(BOOL)
 */
@property (nonatomic, copy, readonly) WBCanTouchChain canTouchChain;

/**
 *  如果touch为YES 这个也可以一起实现  scroreBlockChain(GQScoreBlock)
 */
@property (nonatomic, copy, readonly) WBScoreBlockChain scroreBlockChain;

/**
 *  初始分数    默认满分为5分 0 - 5   scoreNumChain(NSNumber *)
 */
@property (nonatomic, copy, readonly) WBScoreNumChain scoreNumChain;

/**
 底色  默认为[UIColor grayColor]
 */
@property (nonatomic, copy, readonly) WBColorChain normalColorChain;

/**
 高亮色 默认为[UIColor yellowColor]
 */
@property (nonatomic, copy, readonly) WBColorChain highlightColorChian;

/**
 *  显示在哪个view上面   superViewChain(UIView *)
 */
@property (nonatomic, copy, readonly) WBSuperViewChain superViewChain;

#pragma mark -- 方法调用
#pragma mark
/**
 *  initMethod
 *
 *  @param point x y坐标
 *  @param size  单个星星大小
 *
 *  @return GQRatingView
 */
+ (instancetype)initWithPoint:(CGPoint)point withSize:(float)size;

/**
 *  分数是否显示为整数 如果为yes星星都是整个整个显示
 */
@property (nonatomic, assign) BOOL needIntValue;

/**
 *  默认为NO  星星是否可以点击
 */
@property (nonatomic, assign) BOOL canTouch;

/**
 *  如果touch为YES 这个也可以一起实现
 */
@property (nonatomic, copy) WBScoreBlock scroreBlock;

/**
 *  初始分数    默认满分为5分 0 - 5
 */
@property (nonatomic,strong) NSNumber *scoreNum;

/**
 设置底色
 */
@property (nonatomic, strong) UIColor *normalColor;

/**
 设置高亮颜色
 */
@property (nonatomic, strong) UIColor *highlightColor;
@end
