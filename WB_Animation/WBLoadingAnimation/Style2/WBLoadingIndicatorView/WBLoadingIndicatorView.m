//
//  WB_LoadingIndicatorView.m
//  WB_LoadingIndicatorView
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBLoadingIndicatorView.h"
#import "WBDrawCycleView.h"

@interface WBLoadingIndicatorView ()
{
    CGFloat _w;
    CGFloat _r;
}
@property (nonatomic, strong) NSArray *nubmerOfCycleViews;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation WBLoadingIndicatorView

#pragma mark -- 视图初始化
#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initData];
    }
    return self;
}

#pragma mark -- 初始化数据
#pragma mark
- (void)initData {
    _circleColor = [UIColor lightGrayColor];
    _speed = 1.f;
    _numberOfCircleView = 12;
    _circleRadius = 1;
    _circleSize = 1.f;
    self.hidden = YES;
}

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    CGFloat r = self.frame.size.width;
    if (r > self.frame.size.height) {
        r = self.frame.size.height;
    }
    r = r / 2.0;
    r = r * _circleRadius;
    CGFloat w = r * sinf(2 * M_PI / _numberOfCircleView) / 2.0;
    r -= (w / 2.0);
    w = w * _circleSize;
    _r = r;
    _w = w;
    
    NSMutableArray *arr = [NSMutableArray array];
    CGFloat alpha = 1.0;
    for (NSInteger i = 1; i < _numberOfCircleView + 1; i ++) {
        w = _w * i / _numberOfCircleView;
        CGRect rect = CGRectMake(0, 0, w, w);
        WBDrawCycleView *cycleView = [[WBDrawCycleView alloc]initWithFrame:rect];
        cycleView.circleColor = _circleColor;
        cycleView.radian = ((M_PI * 2.0) / _numberOfCircleView) * i;
        CGPoint center = CGPointMake(self.frame.size.width / 2.0 + _r * cos(cycleView.radian),_r * sin(cycleView.radian) + self.frame.size.height / 2.0);
        cycleView.center = center;
        cycleView.alpha = alpha * (_numberOfCircleView - 1) / _numberOfCircleView;
        [self addSubview:cycleView];
        [arr addObject:cycleView];
    }
    self.nubmerOfCycleViews = [arr copy];
}

#pragma mark -- 动画
#pragma mark
- (void)startAnimation {
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 / ( _numberOfCircleView * _speed) target:self selector:@selector(rotate) userInfo:nil repeats:YES];
    self.hidden = NO;
}

- (void)stopAnimation {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        self.hidden = YES;
    }
}

- (void)rotate {
    for (int i = 1; i < _numberOfCircleView + 1; i ++)
    {
        [UIView animateWithDuration:0.1 / (_numberOfCircleView * _speed) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            WBDrawCycleView *cycleView = self.nubmerOfCycleViews[i - 1];
            cycleView.radian +=  M_PI_2 / (2.0 *_numberOfCircleView);
            CGPoint center = CGPointMake(self.frame.size.width / 2.0 + _r * cos(cycleView.radian),self.frame.size.height / 2.0 + _r * sin(cycleView.radian));
            cycleView.center = center;
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupUI];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark -- Getter And Setter
#pragma mark
- (void)setSpeed:(CGFloat)speed {
    if (_speed > 0) {
        _speed = speed;
    }
}
- (void)setNumberOfCircleView:(NSInteger)numberOfCircleView {
    if (numberOfCircleView > 12) {
        numberOfCircleView = numberOfCircleView;
    }
    [self setNeedsLayout];
}

- (void)setCircleSize:(CGFloat)circleSize {
    if (circleSize > 0 && circleSize <= 1) {
        _circleSize = circleSize;
    }
    [self setNeedsLayout];
}

- (void)setCircleRadius:(CGFloat)circleRadius {
    if (circleRadius > 0 && circleRadius <= 1) {
        _circleRadius = circleRadius;
    }
    [self setNeedsLayout];
}


@end
