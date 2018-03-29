//
//  WB_CountdownButton.m
//  WB_CountdownButton
//
//  Created by WMB on 2017/6/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBCountdownButton.h"

#import "WBCountdownButtonManager.h"


@interface WBCountdownButton ()

@property (nonatomic, strong) UILabel *overlayLabel;

@end

@implementation WBCountdownButton

- (void)dealloc {
    NSLog(@"***> %s [%@]", __func__, _identifyKey);
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

#pragma mark -- 创建子视图
#pragma mark
- (void)configUI {
    //config subviews
    self.countDownTime = 60;
    self.identifyKey        = NSStringFromClass([self class]);
    self.clipsToBounds      = YES;
    self.layer.cornerRadius = 4;
    
    [self addSubview:self.overlayLabel];
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //[self configUI];
    self.overlayLabel.frame = self.bounds;
    
    if ([[WBCountdownButtonManager shareManager] countdownTaskExistWithKey:self.identifyKey task:nil]) {
        
        [self shouldCountDown];
    }
    
}

#pragma mark --------  Private Mehtod  --------
#pragma mark
- (void)wb_timeFire {
    
    [self shouldCountDown];
}

- (void)shouldCountDown {
    
    self.enabled             = NO;
    self.titleLabel.alpha    = 0;
    self.overlayLabel.hidden = NO;
    self.overlayLabel.text   = self.titleLabel.text;
    
    self.disabledBackgroundColor ? self.overlayLabel.backgroundColor =  self.disabledBackgroundColor : self.backgroundColor;
    
    self.disabledTitleColor ? self.overlayLabel.textColor = self.disabledTitleColor : self.titleLabel.textColor;
    
    __weak __typeof(self) weakSelf = self;
    [[WBCountdownButtonManager shareManager] scheduledCountDownWithKey:self.identifyKey timeInterval:self.countDownTime countingDown:^(NSTimeInterval leftTimeInterval) {
        
        __strong __typeof(weakSelf) self = weakSelf;
        self.overlayLabel.text = [NSString stringWithFormat:@"%@ 秒后重试", @(leftTimeInterval)];
        
    } finished:^(NSTimeInterval finalTimeInterval) {
        
        __strong __typeof(weakSelf) self = weakSelf;
        self.enabled             = YES;
        self.overlayLabel.hidden = YES;
        self.titleLabel.alpha    = 1;
        [self.overlayLabel setBackgroundColor:self.backgroundColor];
        [self.overlayLabel setTextColor:self.titleLabel.textColor];
        
    }];
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (![[self actionsForTarget:target forControlEvent:UIControlEventTouchUpInside] count]) {
        return;
    }
    
    [super sendAction:action to:target forEvent:event];
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
- (UILabel *)overlayLabel {
    if (!_overlayLabel) {
        _overlayLabel                 = [UILabel new];
        _overlayLabel.textColor       = self.titleLabel.textColor;
        _overlayLabel.backgroundColor = self.backgroundColor;
        _overlayLabel.font            = self.titleLabel.font;
        _overlayLabel.textAlignment   = NSTextAlignmentCenter;
        _overlayLabel.hidden          = YES;
    }
    
    return _overlayLabel;
}

@end
