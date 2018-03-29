//
//  WB_StarRatingView.m
//  WB_StarRatingView
//
//  Created by Admin on 2017/7/25.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBStarRatingView.h"
#import "UIView+WBFrame.h"

@interface WBStarRatingView ()
{
    CGSize starSize;
    NSInteger _numberOfStar;
}
/** 已选中星星图片视图 */
@property (nonatomic , strong ) UIView *checkedImagesView;
/** 未选中星星图片视图 */
@property (nonatomic , strong ) UIView *uncheckedImagesView;
@end
@implementation WBStarRatingView

#pragma mark -- 视图初始化
#pragma mark
- (instancetype)init
{
    NSAssert(NO, @"you shouldn't use init,plase user initWithFrame instead");
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars {
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = numberOfStars;
        [self setupUI];
        [self configLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStars:5];
}

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    _spacing = 5.0f;
    _minLimitScore = 0.0f;
    _maxLimitScore = 5.0f;
    _currentScore = 0.0f;
    _rateStyle = WBStarRateWholeStyle;
    _checkedImageName = @"star_orange";
    _unCheckedImageName = @"game_evaluate_gray";
    [self addSubview:self.uncheckedImagesView];
    [self addSubview:self.checkedImagesView];
    /** 循环初始化已选中和未选中子视图 */
    for (NSInteger i = 0; i < _numberOfStar; i++) {
        UIImageView *uncheckedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_unCheckedImageName]];
        [self.uncheckedImagesView addSubview:uncheckedImage];
        UIImageView *checkedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_checkedImageName]];
        [self.checkedImagesView addSubview:checkedImage];
    }
}

- (void)configLayout {
    [self setupStarSize];
    if (self.uncheckedImagesView.width != self.width || self.uncheckedImagesView.height != starSize.height) {
        self.uncheckedImagesView.frame = CGRectMake(0, 0, self.width, starSize.height);
        self.uncheckedImagesView.center = CGPointMake(self.width / 2.f, self.height / 2.f);
        self.checkedImagesView.frame = CGRectMake(0, self.uncheckedImagesView.top, self.checkedImagesView.width, starSize.height);
        for (NSInteger i = 0; i < _numberOfStar; i ++) {
            UIImageView *unCheckedImage = self.uncheckedImagesView.subviews[i];
            UIImageView * checkedImage = self.checkedImagesView.subviews[i];
            CGRect imageFrame = CGRectMake(i ? (starSize.width + self.spacing) * i + self.spacing : self.spacing, 0, starSize.width, starSize.height);
            unCheckedImage.frame = imageFrame;
            checkedImage.frame = imageFrame;
        }
    }
}

- (void)setupStarSize {
    // 计算星星大小
    if (self.frame.size.width) {
        NSAssert(_numberOfStar * _spacing < self.width, @"间距过长 已超出视图大小");
        CGFloat size = (self.frame.size.width - (_numberOfStar + 1) * _spacing) / _numberOfStar ? : 0;
        starSize = CGSizeMake(size, size);
    }
    // 如果当前高度不等于于星星高度 则设置当前高度为星星高度 update frame
    if (self.frame.size.height != starSize.height) self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, starSize.height);
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
    [self configLayout];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark -- Event Response
#pragma mark
- (void)tapGestureEvent:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self];
    [self updateStarView:[self pointToRatio:point]];
}

- (void)panGestureEvent:(UITapGestureRecognizer *)pan{
    CGPoint point = [pan locationInView:self];
    [self updateStarView:[self pointToRatio:point]];
}

#pragma mark -- update starView
#pragma mark
- (CGFloat)pointToRatio:(CGPoint)point {
    CGFloat ratio = 0.f;
    if (self.spacing > point.x) {
        ratio = 0.f;
    }else if (self.width - self.spacing < point.x) {
        ratio = 1.f;
    }else {
        /* 比例转换
         *
         * 当前点击位置在当前视图宽度中的比例 转换为 当前点击星星位置在全部星星宽度中的比例
         * 当前点击位置去除其中的间距宽度等于星星的宽度 point.x - 间距 = 所选中的星星宽度
         * 所选中的星星宽度 / 所有星星宽度 = 当前选中的比例
         */
        CGFloat itemWidth = self.spacing + starSize.width;
        CGFloat iCount = point.x / itemWidth;
        NSInteger count = floorf(iCount);
        CGFloat added = (itemWidth * (iCount - count));
        added = added >= self.spacing ? self.spacing : added;
        CGFloat x = point.x - self.spacing * count - added;
        
        ratio = x / (starSize.width * _numberOfStar);
    }
    return ratio;
}
- (void)updateStarView:(CGFloat)ratio {
    if (ratio < 0) {
        return;
    }
    if (ratio > 1) {
        return;
    }
    /** 根据类型计算比例 */
    CGFloat width = 0.f;
    switch (self.rateStyle) {
        case WBStarRateWholeStyle:
            ratio = ceilf(_numberOfStar * ratio);
            width = starSize.width * ratio + (self.spacing * roundf(ratio));
            break;
        case WBStarRateHalfStyle:
            ratio = _numberOfStar * ratio;
            CGFloat z = floorf(ratio);
            CGFloat s = ratio - z;
            if (s >= 0.5f) ratio = z + 1.0f;
            
            if (s < 0.5f && s > 0.001f) ratio = z + 0.5f;
            width = starSize.width * ratio + (self.spacing * roundf(ratio));
            break;
        case WBStarRateUnlimitedStyle:
            ratio = _numberOfStar * ratio;
            width = starSize.width * ratio + (self.spacing * ceilf(ratio));
            break;
        default:
            break;
    }
    /** 设置宽度 */
    if (width < 0) {
        width = 0;
    }
    if (width > self.width) {
        width = self.width;
    }
    CGRect checkedImagesViewFrame = self.checkedImagesView.frame;
    checkedImagesViewFrame.size.width = width;
    self.checkedImagesView.frame = checkedImagesViewFrame;
    /** 设置当前分数 */
    NSDecimalNumber *numRatio = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.4lf", ratio / _numberOfStar]];
    NSDecimalNumber *numScore = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.4lf", self.maxLimitScore - self.minLimitScore]];
    NSDecimalNumber *numResult = [numRatio decimalNumberByMultiplyingBy:numScore];
    CGFloat currentScore = numResult.floatValue + self.minLimitScore;
    if (currentScore < self.minLimitScore) currentScore = self.minLimitScore;
    if (currentScore > self.maxLimitScore) currentScore = self.maxLimitScore;
    if (_currentScore != currentScore) {
        _currentScore = currentScore;
        if (_scoreBlock) {
            _scoreBlock(self.currentScore);
        }
    }
}

#pragma mark -- Getter And Setter
#pragma mark
- (UIView *)uncheckedImagesView {
    if (!_uncheckedImagesView) {
        _uncheckedImagesView = [[UIView alloc]init];
    }
    return _uncheckedImagesView;
}

- (UIView *)checkedImagesView {
    if (!_checkedImagesView) {
        _checkedImagesView = [[UIView alloc]init];
        _checkedImagesView.clipsToBounds = YES;
    }
    return _checkedImagesView;
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
    [self setNeedsLayout];
}

- (void)setTouchEnabled:(BOOL)touchEnabled {
    _touchEnabled = touchEnabled;
    if (touchEnabled) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureEvent:)];
        [self addGestureRecognizer:tap];
    }
}

- (void)setSlideEnabled:(BOOL)slideEnabled {
    _slideEnabled = slideEnabled;
    if (slideEnabled) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureEvent:)];
        [self addGestureRecognizer:panGesture];
    }
}

- (void)setCheckedImageName:(NSString *)checkedImageName {
    _checkedImageName = checkedImageName;
    [self.uncheckedImagesView.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        imageView.image = [UIImage imageNamed:checkedImageName];
    }];
}

- (void)setUnCheckedImageName:(NSString *)unCheckedImageName {
    _unCheckedImageName = unCheckedImageName;
    [self.uncheckedImagesView.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        imageView.image = [UIImage imageNamed:unCheckedImageName];
    }];
}

- (void)setCurrentScore:(CGFloat)currentScore{
    NSAssert(self.minLimitScore <= currentScore, @"当前分数小于最小分数");
    NSAssert(self.maxLimitScore >= currentScore, @"当前分数大于最大分数");
    if (currentScore < self.minLimitScore) currentScore = self.minLimitScore;
    if (currentScore > self.maxLimitScore) currentScore = self.maxLimitScore;
    [self updateStarView:(currentScore - self.minLimitScore) / (self.maxLimitScore - self.minLimitScore)];
}

- (void)setMinLimitScore:(CGFloat)minLimitScore {
    _minLimitScore = minLimitScore;
    NSAssert(minLimitScore >= 0, @"最小分数不能小于0");
}

- (void)setMaxLimitScore:(CGFloat)maxLimitScore {
    _maxLimitScore = maxLimitScore;
    NSAssert(maxLimitScore > 0, @"最大分数不能小于0");
    NSAssert(maxLimitScore > self.minLimitScore, @"最大分数不能小于最小分数");
}

@end
