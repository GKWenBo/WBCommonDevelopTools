//
//  WB_LoadingAnimationView.m
//  WB_LoadingAnimationView
//
//  Created by WMB on 2017/9/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBLoadingAnimationView.h"
#import "UIView+WBFrame.h"

static CGFloat const Round_Width = 10;

@interface WBLoadingAnimationView() <CAAnimationDelegate>

@property (nonatomic,weak)UIView *round1;
@property (nonatomic,weak)UIView *round2;
@property (nonatomic,weak)UIView *round3;

@property (nonatomic,strong)UIColor *round1Color;
@property (nonatomic,strong)UIColor *round2Color;
@property (nonatomic,strong)UIColor *round3Color;

@property (nonatomic,assign)CGFloat animRepeatTime;
@property (nonatomic,assign)CGFloat animTime;

@end

@implementation WBLoadingAnimationView

- (void)dealloc {
    NSLog(@"销毁了");
}

#pragma mark -- 初始化
#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self configUI];
    }
    return self;
}


#pragma mark --------  show method  --------
#pragma mark
+ (WBLoadingAnimationView *)wb_showLoadingViewWith:(UIView *)view {
    WBLoadingAnimationView *loadingView = [[WBLoadingAnimationView alloc]initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
    [view addSubview:loadingView];
    return loadingView;
}

+ (WBLoadingAnimationView *)wb_showLoadingViewWithWindow {
     WBLoadingAnimationView *loadingView = [[WBLoadingAnimationView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [[UIApplication sharedApplication].keyWindow addSubview:loadingView];
    return loadingView;
}

#pragma mark --------  hide loadingView  --------
#pragma mark
- (void)wb_hideLoadingView {
    [self.round1.layer removeAllAnimations];
    [self.round2.layer removeAllAnimations];
    [self.round3.layer removeAllAnimations];
    [self removeFromSuperview];
}

#pragma mark -- 创建子视图
#pragma mark
- (void)configUI {
    //config subviews
    [self wb_defaultConfig];
    UIView *round1 = [[UIView alloc]init];
    round1.width = Round_Width;
    round1.height = Round_Width;
    round1.backgroundColor = self.round1Color;
    round1.layer.cornerRadius = round1.width / 2.f;
    [self addSubview:round1];
    
    UIView *round2 = [[UIView alloc]init];
    round2.width = Round_Width;
    round2.height = Round_Width;
    round2.backgroundColor = self.round2Color;
    round2.layer.cornerRadius = round2.width / 2.f;
    [self addSubview:round2];
    
    UIView *round3 = [[UIView alloc]init];
    round3.width = Round_Width;
    round3.height = Round_Width;
    round3.backgroundColor = self.round3Color;
    round3.layer.cornerRadius = round3.width / 2.f;
    [self addSubview:round3];
    
    round2.centerX = self.centerX;
    round2.centerY = self.centerY;
    round1.centerX = round2.centerX - 20;
    round1.centerY = round2.centerY - 20;
    round3.centerX = round2.centerX + 20;
    round3.centerY = round3.centerY;
    
    _round1 = round1;
    _round2 = round2;
    _round3 = round3;
    
    [self wb_startAnimation];
}

- (void)wb_defaultConfig {
    _animTime = 1.5;
    _animRepeatTime = 50;
}

#pragma mark --------  animation  --------
#pragma mark
- (void)wb_startAnimation {
    CGPoint otherRoundCenter1 = CGPointMake(_round1.centerX + 10, _round2.centerY);
    CGPoint otherRoundCenter2 = CGPointMake(_round2.centerX + 10, _round2.centerY);
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:otherRoundCenter1 radius:10 startAngle:- M_PI endAngle:0 clockwise:YES];
    UIBezierPath *path1_1 = [UIBezierPath bezierPath];
    [path1_1 addArcWithCenter:otherRoundCenter2 radius:10 startAngle:- M_PI endAngle:0 clockwise:NO];
    [path1 appendPath:path1_1];
    [self wb_viewMovePathAnimWith:_round1 path:path1 andTime:_animTime];
    [self wb_viewColorAnimWith:self.round1 fromColor:self.round1Color toColor:_round3Color andTime:_animTime];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:otherRoundCenter1 radius:10 startAngle:0 endAngle:- M_PI clockwise:YES];
    [self wb_viewMovePathAnimWith:_round2 path:path2 andTime:_animTime];
    [self wb_viewColorAnimWith:_round2 fromColor:self.round2Color toColor:self.round1Color andTime:_animTime];
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 addArcWithCenter:otherRoundCenter2 radius:10 startAngle:0 endAngle:- M_PI clockwise:NO];
    [self wb_viewMovePathAnimWith:_round3 path:path3 andTime:_animTime];
    [self wb_viewColorAnimWith:self.round3 fromColor:self.round3Color toColor:self.round1Color andTime:_animTime];
}

- (void)wb_viewMovePathAnimWith:(UIView *)view path:(UIBezierPath *)path andTime:(CGFloat)time {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = [path CGPath];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationCubic;
    animation.repeatCount = _animRepeatTime;
    animation.duration = time;
    animation.autoreverses = NO;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void)wb_viewColorAnimWith:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor andTime:(CGFloat)time {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.toValue = (__bridge id _Nullable)([toColor CGColor]);
    animation.fromValue = (__bridge id _Nullable)([fromColor CGColor]);
    animation.duration = time;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeBackwards;
    animation.removedOnCompletion = NO;
    animation.repeatCount = _animRepeatTime;
    [view.layer addAnimation:animation forKey:@"backgroundColor"];
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
    _round2.centerX = self.centerX;
    _round2.centerY = self.centerY;
    _round1.centerX = _round2.centerX - 20;
    _round1.centerY = _round2.centerY - 20;
    _round3.centerX = _round2.centerX + 20;
    _round3.centerY = _round3.centerY;
    //[self configUI];
}

#pragma mark --------  CAAnimationDelegate  --------
#pragma mark
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.round1.layer removeAllAnimations];
    [self.round2.layer removeAllAnimations];
    [self.round3.layer removeAllAnimations];
    [self removeFromSuperview];
}
#pragma mark -- 绘图
#pragma mark
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark -- Getter and Setter
#pragma mark
- (UIColor *)round1Color {
    if (!_round1Color) {
        _round1Color = [UIColor colorWithRed:206/255.0 green:7/255.0 blue:85/255.0 alpha:1.0];
    }
    return _round1Color;
}

- (UIColor *)round2Color {
    if (!_round2Color) {
        _round2Color = [UIColor colorWithRed:206/255.0 green:7/255.0 blue:85/255.0 alpha:0.6];
    }
    return _round2Color;
}

- (UIColor *)round3Color {
    if (!_round3Color) {
        _round3Color = [UIColor colorWithRed:206/255.0 green:7/255.0 blue:85/255.0 alpha:0.6];
    }
    return _round3Color;
}

@end
