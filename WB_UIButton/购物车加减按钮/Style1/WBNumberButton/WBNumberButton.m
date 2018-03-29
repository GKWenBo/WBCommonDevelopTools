//
//  WB_NumberButton.m
//  WB_NumberButton
//
//  Created by WMB on 2017/6/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBNumberButton.h"

#ifdef DEBUG
#define WBLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define PPLog(...)
#endif

@interface WBNumberButton () <UITextFieldDelegate>

@property (nonatomic,strong) UIButton * increaseBtn;
@property (nonatomic,strong) UIButton * decreaseBtn;
@property (nonatomic,strong) UITextField * textField;
@property (nonatomic,strong) NSTimer * timer;

@end

@implementation WBNumberButton

- (void)dealloc {
    
    [self cleanTimer];
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
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
//    self.frame = CGRectMake(0, 0, 110, 30);
    
    /**  加减按钮  */
    self.increaseBtn = [self setupButtonWithTitle:@"＋"]
    ;
    self.decreaseBtn = [self setupButtonWithTitle:@"－"];
    
    [self addSubview:self.textField];
}

#pragma mark --------  UITextFieldDelegate  --------
#pragma mark
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    textField.text.length == 0  || textField.text.integerValue <= 0 ? self.textField.text = @"1" : nil;
    
    self.CountChangeBlock ? self.CountChangeBlock(self.textField.text) : nil;
    self.delegate ? [self.delegate wbNumberButton:self number:self.textField.text] : nil;
    
}

#pragma mark --------  Event Response  --------
#pragma mark
- (void)touchUp:(UIButton *)sednder {
    
    [self cleanTimer];
}

- (void)touchDown:(UIButton *)sender {
    
    [self.textField resignFirstResponder];
    
    if (sender == self.increaseBtn) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.15f target:self selector:@selector(increase) userInfo:nil repeats:YES];
        
    }else {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.15f target:self selector:@selector(decrease) userInfo:nil repeats:YES];
        
    }
    
    [self.timer fire];
}

- (void)increase {
    
    self.textField.text.length == 0 ? self.textField.text = @"1" : nil;
    NSInteger number = [self.textField.text integerValue] + 1;
    self.textField.text = [NSString stringWithFormat:@"%ld",number];
    
    self.CountChangeBlock ? self.CountChangeBlock(self.textField.text) : nil;
    
    self.delegate ? [self.delegate wbNumberButton:self number:self.textField.text] : nil;
}

- (void)decrease {
    
    self.textField.text.length == 0 ? self.textField.text = @"1" : nil;
    NSInteger number = [self.textField.text integerValue] - 1;
    
    if (number > 0) {
        
        self.textField.text = [NSString stringWithFormat:@"%ld",number];
        
        self.CountChangeBlock ? self.CountChangeBlock(self.textField.text) : nil;
        
        self.delegate ? [self.delegate wbNumberButton:self number:self.textField.text] : nil;
        
    }else {
        
        self.shakeAnimation ? [self shakeAnimation] : nil;
        NSLog(@"数量不能小于1");
    }
}

#pragma mark --------  Private Method  --------
#pragma mark
- (UIButton *)setupButtonWithTitle:(NSString *)text
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel];
    [self addSubview:button];
    return button;
}

- (void)cleanTimer {
    
    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //[self configUI];
    /**  布局  */
    //加减按钮为正方形
    CGFloat height = self.frame.size.height;
    CGFloat width =  self.frame.size.width;
    self.decreaseBtn.frame = CGRectMake(0, 0, height, height);
    self.increaseBtn.frame = CGRectMake(width - height, 0, height, height);
    self.textField.frame = CGRectMake(height, 0, width - 2 * height, height);
}


#pragma mark --------  设置按钮 注意：只能调用其中一个方法  --------
#pragma mark
/**
 *  设置加、减按钮标题
 *
 *  @param increaseTitle 加按钮标题
 *  @param decreaseTitle 减按钮标题
 */
- (void)wb_setIncreaseTitle:(NSString *)increaseTitle
              decreaseTitle:(NSString *)decreaseTitle {
    
    [self.increaseBtn setTitle:increaseTitle forState:UIControlStateNormal];
    [self.decreaseBtn setTitle:decreaseTitle forState:UIControlStateNormal];
}
- (void)wb_setIncreaseNormalImage:(NSString *)increaseNormalImage increaseHighlightImage:(NSString *)increaseHighlightImage decreaseNormalImage:(NSString *)decreaseNormalImage decreaseHighlightImage:(NSString *)decreaseHighlightImage {
    
    [self.increaseBtn setImage:[UIImage imageNamed:increaseNormalImage] forState:UIControlStateNormal];
    [self.increaseBtn setImage:[UIImage imageNamed:increaseHighlightImage] forState:UIControlStateHighlighted];
    
    [self.decreaseBtn setImage:[UIImage imageNamed:decreaseNormalImage] forState:UIControlStateNormal];
    [self.decreaseBtn setImage:[UIImage imageNamed:decreaseHighlightImage] forState:UIControlStateHighlighted];
}

#pragma mark --------  动画方法  --------
#pragma mark
- (void)shakeAnimation {
    
    CAKeyframeAnimation * keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    
    CGFloat position_X = self.layer.position.x;
    keyFrameAnimation.values = @[@(position_X - 10),@(position_X),@(position_X + 10)];
    keyFrameAnimation.repeatCount = 3;
    keyFrameAnimation.duration = 0.07;
    keyFrameAnimation.autoreverses = YES;
    [self.layer addAnimation:keyFrameAnimation forKey:nil];
    
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
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.text = @"1";
        _textField.delegate = self;
        _textField.font = [UIFont boldSystemFontOfSize:15];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _textField;
}
- (void)setFont:(UIFont *)font {
    _font = font;
    self.increaseBtn.titleLabel.font = font;
    self.decreaseBtn.titleLabel.font = font;
}
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    self.layer.borderColor = [borderColor CGColor];
    self.increaseBtn.layer.borderColor = borderColor.CGColor;
    self.decreaseBtn.layer.borderColor = borderColor.CGColor;
    
    self.layer.borderWidth = 1.f;
    self.increaseBtn.layer.borderWidth = 1.f;
    self.decreaseBtn.layer.borderWidth = 1.f;
    
}
- (void)setNumber:(NSString *)number {

    self.textField.text = number;
}
- (NSString *)number {
    
    return self.textField.text;
}

@end
