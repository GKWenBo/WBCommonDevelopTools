//
//  WB_LogisticsInfomationContentView.m
//  WB_LogisticsInfomationDemo
//
//  Created by Admin on 2017/7/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBLogisticsInfomationContentView.h"
#import "WBLogisticsInfomationConfig.h"

@interface WBLogisticsInfomationContentView ()
@property (nonatomic, strong) UIView *lineView;
@end
@implementation WBLogisticsInfomationContentView
#pragma mark -- 视图初始化
#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.infoLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.lineView];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).insets(UIEdgeInsetsMake(10, WB_LeftSpace, 0, WB_RightSpace));
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabel.mas_bottom).offset(10);
        make.left.equalTo(self.infoLabel);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(WB_LeftSpace);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(@1);
    }];
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark -- 赋值
#pragma mark
- (void)reloadDataWithModel:(WBLogisticsInfomationModel *)model {
    self.infoLabel.text = model.dsc;
    self.dateLabel.text = model.date;
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat height = self.bounds.size.height;
    CGFloat circleWith = self.currented ? 12 : 6;
    if (self.hasUpLine) {
        UIBezierPath * topBezier = [UIBezierPath bezierPath];
        [topBezier moveToPoint:CGPointMake(WB_LeftSpace / 2.f, 0)];
        [topBezier addLineToPoint:CGPointMake(WB_LeftSpace / 2.f, height/2.0 - circleWith/2.0 - circleWith/6.0)];
        topBezier.lineWidth = 1.f;
        UIColor * stroke = RGB_COLOR(185, 185, 185);
        [stroke set];
        [topBezier stroke];
    }
    if (self.currented) {
        UIBezierPath * circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(WB_LeftSpace / 2.f - circleWith / 2.f, height/2.0 - circleWith/2.0, circleWith, circleWith)];
        circle.lineWidth = circleWith  / 3.f;
        UIColor * cColor = RGB_COLOR(255, 128, 0);
        [cColor set];
        [circle fill];
        [circle stroke];
    } else {
        UIBezierPath * circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(WB_LeftSpace / 2.f - circleWith / 2.f, height/2.0 - circleWith/2.0, circleWith, circleWith)];
        circle.lineWidth = circleWith  / 3.f;
        UIColor * cColor = RGB_COLOR(185, 185, 185);
        [cColor set];
        [circle fill];
        [circle stroke];
    }
    if (self.hasDownLine) {
        UIBezierPath *downBezier = [UIBezierPath bezierPath];
        [downBezier moveToPoint:CGPointMake(WB_LeftSpace/2.0, height/2.0 + circleWith/2.0 + circleWith/6.0)];
        [downBezier addLineToPoint:CGPointMake(WB_LeftSpace/2.0, height)];
        downBezier.lineWidth = 1.0;
        UIColor *stroke = RGB_COLOR(185, 185, 185);
        [stroke set];
        [downBezier stroke];
    }
}

#pragma mark -- Getter And Setter
#pragma mark
- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [UILabel new];
        _infoLabel.font = [UIFont systemFontOfSize:12.f];
        _infoLabel.numberOfLines = 0;
        _infoLabel.textColor = self.currented ? RGB_COLOR(0, 0, 0) : RGB_COLOR(139, 139, 139);
        _infoLabel.text = @"[北京顺义区顺义机场公司]派件人:xxx 派件中 派件员电话12345666777";
    }
    return _infoLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textColor = RGB_COLOR(185, 185, 185);
        _dateLabel.font = [UIFont systemFontOfSize:12.f];
        _dateLabel.text = @"2016-07-13 04:30";
    }
    return _dateLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = RGB_COLOR(238, 238, 238);
    }
    return _lineView;
}

- (void)setCurrented:(BOOL)currented {
    _currented = currented;
    self.infoLabel.textColor = currented ? RGB_COLOR(0, 0, 0) : RGB_COLOR(139, 139, 139);
}

@end
