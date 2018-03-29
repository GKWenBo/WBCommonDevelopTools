//
//  WB_StarRatingView.m
//  WB_StarRatingView
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBStarRatingView.h"

#define kBACKGROUND_STAR @"star_normal"
#define kFOREGROUND_STAR @"star_highlight"
#define kNUMBER_OF_STAR  5

@interface WBStarRatingView ()

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;
@end

@implementation WBStarRatingView

#pragma mark -- 视图初始化
#pragma mark
- (instancetype)initWithFrame:(CGRect)frame numberOfStar:(NSInteger)numberOfStar {
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = numberOfStar;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStar:kNUMBER_OF_STAR];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _numberOfStar = kNUMBER_OF_STAR;
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _numberOfStar = kNUMBER_OF_STAR;
    [self commonInit];
}

#pragma mark -- 设置UI
#pragma mark
- (void)commonInit
{
    self.starBackgroundView = [self buidlStarViewWithImageName:kBACKGROUND_STAR];
    self.starForegroundView = [self buidlStarViewWithImageName:kFOREGROUND_STAR];
    [self addSubview:self.starBackgroundView];
    [self addSubview:self.starForegroundView];
    [self changeStarForegroundViewWithPoint:CGPointZero];
}

#pragma mark -- set score
#pragma mark
- (void)setScore:(CGFloat)score isAnimated:(BOOL)isAnimated {
    [self setScore:score isAnimated:isAnimated completion:^(BOOL isFinished) {
    }];
}

- (void)setScore:(CGFloat)score isAnimated:(BOOL)isAnimated completion:(void (^)(BOOL))completion {
    NSAssert(score >= 0 && score <= 1, @"score must be between 0 and 1");
    if (score < 0) {
        score = 0;
    }
    if (score > 1) {
        score = 1;
    }
    CGPoint point = CGPointMake(score * self.frame.size.width, 0);
    if (isAnimated) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.2f animations:^{
            [weakSelf changeStarForegroundViewWithPoint:point];
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    }else {
        [self changeStarForegroundViewWithPoint:point];
    }
}

#pragma mark -
#pragma mark - Buidl Star View

/**
 *  通过图片构建星星视图
 *
 *  @param imageName 图片名称
 *
 *  @return 星星视图
 */
- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.numberOfStar; i ++){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar, frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}

#pragma mark -
#pragma mark - Change Star Foreground With Point

/**
 *  通过坐标改变前景视图
 *
 *  @param point 坐标
 */
- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    
    if (p.x < 0){
        p.x = 0;
    }
    
    if (p.x > self.frame.size.width){
        p.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    float score = [str floatValue];
    p.x = score * self.frame.size.width;
    self.starForegroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(wb_starRatingView:score:)]){
        [self.delegate wb_starRatingView:self score:score];
    }
    if (_scoreChangeBlock) {
        _scoreChangeBlock(score);
    }
}

#pragma mark -
#pragma mark - Touche Event
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect,point)){
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak __typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf changeStarForegroundViewWithPoint:point];
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

@end
