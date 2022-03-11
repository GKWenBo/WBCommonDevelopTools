//
//  WBTransitionAnimation.h
//  WBTransitionAnimationDemo
//
//  Created by wenbo on 2022/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 动画类型
typedef NS_ENUM(NSInteger, WBTransitionAnimationStyle) {
    /// 上进下出
    WBTransitionAnimationStyleFromTop
};

typedef NS_ENUM(NSInteger, WBTransitionStyle) {
    /// 入场
    WBTransitionStylePresent,
    /// 出场
    WBTransitionStyleDismiss
};

@interface WBTransitionAnimation : NSObject <UIViewControllerTransitioningDelegate>

/// 入场动画时间 默认：0.3s
@property (nonatomic, assign) CGFloat presentDuration;
/// 出场动画时间 默认：.2s
@property (nonatomic, assign) CGFloat dismissDuration;

- (instancetype)initWithTransitionStyle:(WBTransitionAnimationStyle)style;
+ (instancetype)transitionWithStyle:(WBTransitionAnimationStyle)style;

@end

NS_ASSUME_NONNULL_END
