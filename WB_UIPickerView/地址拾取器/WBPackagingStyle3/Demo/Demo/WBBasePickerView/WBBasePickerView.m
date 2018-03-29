//
//  WB_BasePickerView.m
//  WB_BasePickerViewDemo
//
//  Created by Admin on 2017/7/13.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBBasePickerView.h"
#import "UIImage+WBEffect.h"
/*
 设置RGB颜色/设置RGBA颜色
 */
#define RGB_COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/*
 屏幕宽高
 */
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
/**
 自适应大小
 */
#define AUTOLAYOUTSIZE(size) ((size) * (SCREEN_WIDTH / 375))
@interface WBBasePickerView ()
@property (nonatomic, strong) UILabel *titleTextLabel;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
/** 模糊背景视图 */
@property (nonatomic, strong) UIImageView *blurImageView;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@end
@implementation WBBasePickerView

- (void)dealloc {
    NSLog(@"销毁了");
}
#pragma mark -- 视图初始化
#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDefault];
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefault];
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setDefault];
        [self setupUI];
    }
    return self;
}

#pragma mark -- 设置UI
#pragma mark
- (void)setDefault {
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.bounds = SCREEN_BOUNDS;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
    [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _title = nil;
    _effectImage = [UIImage wb_imageWithColor:RGB_COLOR(248, 248, 255)];
    _font = [UIFont systemFontOfSize:17];
    _titleColor = [UIColor blackColor];
    _lineColor = RGB_COLOR(205, 205, 205);
    _contentHeight = 240;
    _contentMode = WBPickerContentModeBottom;
    _showTimeInterval = 0.25;
    _dismissimeInterval = 0.15;

    [self addSubview:self.contentView];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.confirmBtn];
    [self.contentView addSubview:self.topLineView];
    [self.contentView addSubview:self.pickerView];
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.titleTextLabel];
    [self.contentView insertSubview:self.blurImageView atIndex:0];
    [self.contentView insertSubview:self.effectView aboveSubview:self.blurImageView];
}

- (void)setupUI {
    
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.contentMode) {
        case WBPickerContentModeCenter:
            self.cancelBtn.top = self.pickerView.bottom;
            self.confirmBtn.top = self.pickerView.bottom;
            break;
        default:
            break;
    }
}

#pragma mark -- Animations
#pragma mark
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    switch (self.contentMode) {
        case WBPickerContentModeBottom:
        {
            [UIView animateWithDuration:self.showTimeInterval delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.contentView.top -= self.contentView.height;
                self.layer.opacity = 1.f;
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case WBPickerContentModeCenter:
        {
            [UIView animateWithDuration:self.showTimeInterval delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.layer setOpacity:1.0];
                self.contentView.centerY = self.centerY;
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        default:
            break;
    }
}

- (void)dismiss {
    switch (self.contentMode) {
        case WBPickerContentModeBottom:
        {
            [UIView animateWithDuration:self.dismissimeInterval delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.contentView.top += self.bottom;
                self.layer.opacity = 0.f;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
            break;
        case WBPickerContentModeCenter:
        {
            [UIView animateWithDuration:self.dismissimeInterval delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.layer setOpacity:0.0];
                self.contentView.top = self.bottom;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark -- Events Response
#pragma mark
- (void)confirmBtnClicked {
    [self dismiss];
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
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.contentHeight)];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.topLineView.bottom, SCREEN_WIDTH, self.contentView.height - self.topLineView.bottom)];
        _pickerView.backgroundColor = [UIColor clearColor];
    }
    return _pickerView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(kWBMargin, 0, kWBNavigationBarHeight, kWBNavigationBarHeight);
        [_cancelBtn setTitle:@"取消" forState:0];
        _cancelBtn.titleLabel.font = self.font;
        [_cancelBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(SCREEN_WIDTH - kWBMargin - kWBNavigationBarHeight, 0, kWBNavigationBarHeight, kWBNavigationBarHeight);
        [_confirmBtn setTitle:@"确定" forState:0];
        _confirmBtn.titleLabel.font = self.font;
        [_confirmBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, kWBNavigationBarHeight, SCREEN_WIDTH, 0.5)];
        _topLineView.backgroundColor = RGB_COLOR(205, 205, 205);
    }
    return _topLineView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.pickerView.bottom, SCREEN_WIDTH, 0.5)];
        _bottomLineView.backgroundColor = RGB_COLOR(205, 205, 205);
    }
    return _bottomLineView;
}

- (UILabel *)titleTextLabel {
    if (!_titleTextLabel) {
        _titleTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 2 * kWBNavigationBarHeight - 2 * kWBMargin, kWBNavigationBarHeight)];
        _titleTextLabel.centerX = self.contentView.centerX;
        _titleTextLabel.text = self.title;
        _titleTextLabel.textColor = self.titleColor;
        _titleTextLabel.font = self.font;
        _titleTextLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleTextLabel;
}

- (UIImageView *)blurImageView {
    if (!_blurImageView) {
        _blurImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.contentHeight)];
        _blurImageView.image = self.effectImage;
        _blurImageView.contentMode = UIViewContentModeScaleAspectFill;
        _blurImageView.clipsToBounds = YES;
    }
    return _blurImageView;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        _effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentHeight);
    }
    return _effectView;
}

- (void)setContentMode:(WBPickerContentMode)contentMode {
    _contentMode = contentMode;
    if (contentMode == WBPickerContentModeCenter) {
        self.contentView.height += kWBNavigationBarHeight;
        self.effectView.height += kWBNavigationBarHeight;
        self.blurImageView.height += kWBNavigationBarHeight;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleTextLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self.confirmBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:titleColor forState:UIControlStateNormal];
    self.titleTextLabel.textColor = titleColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.titleTextLabel.font = font;
    self.cancelBtn.titleLabel.font = font;
    self.confirmBtn.titleLabel.font = font;
}

- (void)setContentHeight:(CGFloat)contentHeight {
    _contentHeight = contentHeight;
    self.contentView.height = contentHeight;
    self.blurImageView.height = contentHeight;
    self.effectView.height = contentHeight;
    self.pickerView.height = self.contentView.height - self.topLineView.bottom;
    self.bottomLineView.top = self.pickerView.bottom;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.topLineView.backgroundColor = lineColor;
    self.bottomLineView.backgroundColor = lineColor;
}

- (void)setCancelImage:(NSString *)cancelImage {
    _cancelImage = cancelImage;
    UIImage * image = [UIImage imageNamed:cancelImage];
    [self.cancelBtn setImage:image forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@"" forState:UIControlStateNormal];
}

- (void)setConfirmImage:(NSString *)confirmImage {
    _confirmImage = confirmImage;
    UIImage * image = [UIImage imageNamed:confirmImage];
    [self.confirmBtn setImage:image forState:UIControlStateNormal];
    [self.confirmBtn setTitle:@"" forState:UIControlStateNormal];
}

- (void)setEffectImage:(UIImage *)effectImage {
    _effectImage = effectImage;
    if (effectImage != nil) {
        self.blurImageView.image = effectImage;
    }
}

@end
