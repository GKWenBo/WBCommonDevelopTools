//
//  WBTransitionAnimation.m
//  WBTransitionAnimationDemo
//
//  Created by wenbo on 2022/3/11.
//

#import "WBTransitionAnimation.h"

@interface WBTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) WBTransitionAnimationStyle animationStyle;
@property (nonatomic, assign) WBTransitionStyle transitionStyle;
/// 入场动画时间 默认：0.3s
@property (nonatomic, assign) CGFloat presentDuration;
/// 出场动画时间 默认：.2s
@property (nonatomic, assign) CGFloat dismissDuration;

- (instancetype)initWithTransitionStyle:(WBTransitionAnimationStyle)style;

@end


@implementation WBTransitionAnimator

- (instancetype)initWithTransitionStyle:(WBTransitionAnimationStyle)style
{
    self = [super init];
    if (self) {
        _animationStyle = style;
        _transitionStyle = WBTransitionStylePresent;
    }
    return self;
}

// MARK: - UIViewControllerAnimatedTransitioning
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_transitionStyle) {
        case WBTransitionStylePresent:
            [self presentAnimationWithTransitionContext:transitionContext];
            break;
        case WBTransitionStyleDismiss:
            [self dismissAnimationWithTransitionContext:transitionContext];
            break;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return [self transitionDuration];
}

// MARK: - private method
- (NSTimeInterval)transitionDuration {
    switch (_transitionStyle) {
        case WBTransitionStylePresent:
            return self.presentDuration;
        case WBTransitionStyleDismiss:
            return self.dismissDuration;
            break;
    }
}

- (void)presentAnimationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    
    switch (_animationStyle) {
        case WBTransitionAnimationStyleFromTop:
        {
            [containerView addSubview:toVC.view];
            
            fromVC.view.userInteractionEnabled = NO;
            toVC.view.frame = CGRectMake(0, -CGRectGetHeight(containerView.frame), CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame));
            toVC.view.alpha = 0.f;
            // animation
            [UIView animateWithDuration:[self transitionDuration]
                                  delay:0.f
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                toVC.view.alpha = 1.f;
                toVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame));
            }
                             completion:^(BOOL finished) {
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                fromVC.view.userInteractionEnabled = YES;
            }];
        }
            break;
    }
}

- (void)dismissAnimationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_animationStyle) {
        case WBTransitionAnimationStyleFromTop:
        {
            UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            
            // 这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
            UIView *containerView = [transitionContext containerView];
            
            toVC.view.userInteractionEnabled = YES;
            
            fromVC.view.userInteractionEnabled = NO;
            fromVC.view.alpha = 1.f;
            [UIView animateWithDuration:[self transitionDuration]
                             animations:^{
                fromVC.view.alpha = 0.f;
                fromVC.view.frame = CGRectMake(0, -CGRectGetHeight(containerView.frame), CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame));
            }
                             completion:^(BOOL finished) {
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                fromVC.view.userInteractionEnabled = YES;
            }];
        }
            break;
    }
}

@end


@interface WBTransitionAnimation ()

@property (nonatomic, assign) WBTransitionAnimationStyle style;
@property (nonatomic, strong) WBTransitionAnimator *animator;

@end

@implementation WBTransitionAnimation

+ (instancetype)transitionWithStyle:(WBTransitionAnimationStyle)style {
    return [[self alloc] initWithTransitionStyle:style];
}

- (instancetype)initWithTransitionStyle:(WBTransitionAnimationStyle)style
{
    self = [super init];
    if (self) {
        _style = style;
        _presentDuration = .3f;
        _dismissDuration = .2f;
    }
    return self;
}

// MARK: - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.animator.transitionStyle = WBTransitionStylePresent;
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animator.transitionStyle = WBTransitionStyleDismiss;
    return self.animator;
}

// MARK: - getter && setter
- (WBTransitionAnimator *)animator {
    if (!_animator) {
        _animator = [[WBTransitionAnimator alloc] initWithTransitionStyle:_style];
        _animator.presentDuration = self.presentDuration;
        _animator.dismissDuration = self.dismissDuration;
    }
    return _animator;
}

- (void)setPresentDuration:(CGFloat)presentDuration {
    _presentDuration = presentDuration;
    
    self.animator.presentDuration = presentDuration;
}

- (void)setDismissDuration:(CGFloat)dismissDuration {
    _dismissDuration = dismissDuration;
    
    self.animator.dismissDuration = dismissDuration;
}

@end
