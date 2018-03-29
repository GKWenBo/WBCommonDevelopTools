//
//  WB_DatePickerView.m
//  WB_DatePickerView
//
//  Created by Admin on 2017/7/13.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBDatePickerView.h"
#import "UIImage+WBEffect.h"
#define DayFormatLine       @"yyyy-MM-dd"
#define CustomDateFormat    @"yyyy-MM-dd HH:mm:ss"
@interface WBDatePickerView ()
{
    NSDate * selectedDate;
    NSString * selectedDateString;
}
@property (nonatomic, strong) UILabel *titleTextLabel;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
/** 模糊背景视图 */
@property (nonatomic, strong) UIImageView *blurImageView;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@end
@implementation WBDatePickerView

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
    _font = [UIFont systemFontOfSize:17];
    _titleColor = [UIColor blackColor];
    _lineColor = RGB_COLOR(205, 205, 205);
    _effectImage = [UIImage wb_imageWithColor:RGB_COLOR(248, 248, 255)];
    _contentMode = WBPickerContentModeBottom;
    _showTimeInterval = 0.25;
    _dismissimeInterval = 0.15;
    _dateMode = UIDatePickerModeDate;
    _minDate = [self date:@"1970-01-01 00:00" WithFormat:@"yyyy-MM-dd HH:mm"];
    _maxDate = [self date:@"9999-12-31 23:59" WithFormat:@"yyyy-MM-dd HH:mm"];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.confirmBtn];
    [self.contentView addSubview:self.topLineView];
    [self.contentView addSubview:self.datePickerView];
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
            self.cancelBtn.top = self.datePickerView.bottom;
            self.confirmBtn.top = self.datePickerView.bottom;
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

#pragma mark -- evnet response
#pragma mark
- (void)confirmBtnClicked {
    selectedDate = self.datePickerView.date;
    selectedDateString = [self wb_dateStringFromDate:self.datePickerView.date format:DayFormatLine];
    NSLog(@"%@",selectedDateString);
    if (_DidSelectedDateBlock) {
        _DidSelectedDateBlock(selectedDateString,selectedDate);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(wb_datePickerView:dateString:date:)]) {
        [_delegate wb_datePickerView:self dateString:selectedDateString date:selectedDate];
    }
    [self dismiss];
}

//- (void)didSelectedDate:(UIDatePicker *)picker {
//    selectedDate = picker.date;
//    selectedDateString = [self wb_dateStringFromDate:picker.date format:DayFormatLine];
//    NSLog(@"%@",selectedDateString);
//}

#pragma mark -- Private Method
#pragma mark
- (NSDate *)wb_dateWithDaysFromNow:(NSUInteger)days {
    return [[NSDate date] initWithTimeIntervalSinceNow:days * 24 * 60 * 60];
}

- (NSString *)wb_dateStringFromDate:(NSDate *)date
                             format:(NSString *)format {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}
- (NSDate *)date:(NSString *)datestr WithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:datestr];
#if ! __has_feature(objc_arc)
    [dateFormatter release];
#endif
    return date;
}
#pragma mark -- Getter And Setter
#pragma mark
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 216 + kWBNavigationBarHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIDatePicker *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.topLineView.bottom, SCREEN_WIDTH, self.contentView.height - self.topLineView.bottom)];
        _datePickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        _datePickerView.date = [NSDate date];
        _datePickerView.minimumDate = self.minDate;
        _datePickerView.maximumDate = self.maxDate;
        _datePickerView.backgroundColor = [UIColor whiteColor];
        _datePickerView.datePickerMode = self.dateMode;
//        [_datePickerView addTarget:self action:@selector(didSelectedDate:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePickerView;
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
        _bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.datePickerView.bottom, SCREEN_WIDTH, 0.5)];
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
        _blurImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 216 + kWBNavigationBarHeight)];
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
        _effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 216 + kWBNavigationBarHeight);
    }
    return _effectView;
}

- (void)setContentMode:(WBPickerContentMode)contentMode {
    _contentMode = contentMode;
    if (contentMode == WBPickerContentModeCenter) {
        self.contentView.height += kWBNavigationBarHeight;
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

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.topLineView.backgroundColor = lineColor;
    self.bottomLineView.backgroundColor = lineColor;
}

- (void)setMinDate:(NSDate *)minDate {
    _minDate = minDate;
    self.datePickerView.minimumDate = minDate;
}

- (void)setMaxDate:(NSDate *)maxDate {
    _maxDate = maxDate;
    self.datePickerView.maximumDate = maxDate;
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
