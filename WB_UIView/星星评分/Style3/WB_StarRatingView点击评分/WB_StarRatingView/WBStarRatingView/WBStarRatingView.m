//
//  WB_StarRatingView.m
//  WB_StarRatingView
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBStarRatingView.h"

#define FOREGROUND_STAR_IMAGE_NAME @"b27_icon_star_yellow"
#define BACKGROUND_STAR_IMAGE_NAME @"b27_icon_star_gray"
#define DEFALUT_STAR_NUMBER 5
#define ANIMATION_TIME_INTERVAL 0.2

@interface WBStarRatingView ()
@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;
@property (nonatomic, assign) NSInteger numberOfStars;
@end

@implementation WBStarRatingView

#pragma mark -- 视图初始化
#pragma mark
- (instancetype)init
{
    NSAssert(NO, @"You should never call this method in this class. Use initWithFrame: instead!");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStars:DEFALUT_STAR_NUMBER];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _numberOfStars = DEFALUT_STAR_NUMBER;
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars {
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStars = numberOfStars;
        [self setupUI];
    }
    return self;
}

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    _hasAnimation = NO;             /** 默认无动画 */
//    _allowIncompleteStar = NO;    /** 默认不能半星 */
    _style = WBStarRateWholeStyle;  /** 默认整星 */
    self.foregroundStarView = [self createStarViewWithImage:FOREGROUND_STAR_IMAGE_NAME];
    self.backgroundStarView = [self createStarViewWithImage:BACKGROUND_STAR_IMAGE_NAME];
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

#pragma mark -- build stars
#pragma mark
- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

#pragma mark -- Events Response
#pragma mark
- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    switch (self.style) {
        case WBStarRateWholeStyle:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case WBStarRateHalfStyle:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case WBStarRateIncompleteStyle:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    CGFloat animationInterval = self.hasAnimation ? ANIMATION_TIME_INTERVAL : 0;
    [UIView animateWithDuration:animationInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.currentScore / self.numberOfStars, weakSelf.bounds.size.height);
    }];
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
- (void)setCurrentScore:(CGFloat)currentScore {
    if (_currentScore == currentScore) {
        return;
    }
    if (currentScore < 0) {
        _currentScore = 0;
    } else if (currentScore > _numberOfStars) {
        _currentScore = _numberOfStars;
    } else {
        _currentScore = currentScore;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(wb_starRatingView:scoreDidChange:)]) {
        [_delegate wb_starRatingView:self scoreDidChange:_currentScore];
    }
    if (_scoreChangeBlock) {
        _scoreChangeBlock(_currentScore);
    }
    [self setNeedsLayout];
}

@end
