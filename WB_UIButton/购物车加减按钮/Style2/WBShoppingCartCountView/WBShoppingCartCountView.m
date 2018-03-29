//
//  WB_ShoppingCartCountView.m
//  WB_ShoppingCartCountView
//
//  Created by WMB on 2017/6/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBShoppingCartCountView.h"

@interface WBShoppingCartCountView ()

@property (nonatomic,strong) UIButton * deleteBtn;
@property (nonatomic,strong) UIButton * addBtn;
@property (nonatomic,strong) UITextField * textField;
@property (nonatomic,strong) UIView * leftLineView;
@property (nonatomic,strong) UIView * rightLineView;
@property (nonatomic,strong) NSTimer * timer;


@end

@implementation WBShoppingCartCountView

#pragma mark -- 初始化
#pragma mark

- (void)dealloc {
    
    [self cleanTimer];
}

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
    self.maxCount = @"5";
    UIColor *lineColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    
    self.frame = CGRectMake(0, 0, 110, 30);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 2;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [lineColor CGColor];
    
    [self addSubview:self.leftLineView];
    [self addSubview:self.rightLineView];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.addBtn];
    [self addSubview:self.textField];
    
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat viewH = self.frame.size.height;
    CGFloat viewW = self.frame.size.width;
    
    self.leftLineView.frame = CGRectMake(viewH, 0, 1.f, viewH);
    self.rightLineView.frame = CGRectMake(viewW - viewH, 0, 1.f, viewH);
    self.deleteBtn.frame = CGRectMake(0, 0, viewH, viewH);
    self.addBtn.frame = CGRectMake(viewW - viewH, 0, viewH, viewH);
    self.textField.frame = CGRectMake(viewH, 0, viewW - 2 * viewH, viewH);
    
    //[self configUI];
    
}

#pragma mark --------  Event Response  --------
#pragma mark
- (void)btnTouchDown:(UIButton *)sender {
    
    [self.textField resignFirstResponder];
    
    if (sender == self.deleteBtn) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(deleteAction) userInfo:nil repeats:YES];
    }else {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(addAction) userInfo:nil repeats:YES];
    }
    [self.timer fire];
}

- (void)btnTouchUp:(UIButton *)sender {
    
    [self cleanTimer];
}


- (void)addAction {
    if (self.textField.text.length == 0) {
        self.textField.text = @"1";
    }
    
    NSInteger newNum = [self.textField.text integerValue] + 1;
    
    if (newNum > [self.maxCount integerValue]) {
        
        NSLog(@"不能超过%@个",self.maxCount);
        return;
    }
    
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)newNum];
    
    if (self.CurrentCountBlock) {
        
        self.CurrentCountBlock(self.textField.text);
    }
}

- (void)deleteAction {
    if (self.textField.text.length == 0) {
        self.textField.text = @"1";
    }
    
    NSInteger newNum = [self.textField.text integerValue] - 1;
    if (newNum > 0) {
        self.textField.text = [NSString stringWithFormat:@"%ld",(long)newNum];
        
        if (self.CurrentCountBlock) {
            
            self.CurrentCountBlock(self.textField.text);
        }
        
    }else {
        NSLog(@"数量不能小于1");
    }
}

#pragma mark --------  Private Method  --------
#pragma mark
- (void)setupButton:(UIButton *)btn normalImage:(NSString *)norImage HighlightImage:(NSString *)highImage{
    [btn setImage:[self readImageFromBundle:norImage] forState:UIControlStateNormal];
    [btn setImage:[self readImageFromBundle:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnTouchDown:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(btnTouchUp:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel];
}
- (UIImage *)readImageFromBundle:(NSString *)imageName {
    
    NSString * path = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"WB_ShoppingCartCountViewImages.bundle"];
    NSBundle * bundle = [NSBundle bundleWithPath:path];
    
    UIImage * (^getBoundleImage) (NSString *) = ^(NSString * n) {
        return [UIImage imageWithContentsOfFile:[bundle pathForResource:n ofType:@"png"]];
    };
    UIImage *myImg = getBoundleImage(imageName);
    return myImg;
}

- (void)cleanTimer {
    
    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
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
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    
    self.layer.borderColor = lineColor.CGColor;
    self.leftLineView.backgroundColor = lineColor;
    self.rightLineView.backgroundColor = lineColor;
}
- (void)setCurrentCount:(NSString *)currentCount {
   
    self.textField.text = currentCount;
}
- (NSString *)currentCount {
    
    return self.textField.text;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField = [[UITextField alloc] init];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:15];
        _textField.text = @"1";
    }
    return _textField;
}
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setupButton:_addBtn normalImage:@"increase@2x" HighlightImage:@"increase2@2x"];
    }
    return _addBtn;
}
- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setupButton:_deleteBtn normalImage:@"decrease@2x" HighlightImage:@"decrease2@2x"];
    }
    return _deleteBtn;
}
- (UIView *)leftLineView {
    if (!_leftLineView) {
        UIColor *lineColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        _leftLineView = [[UIView alloc]init];
        _leftLineView.backgroundColor = lineColor;
    }
    return _leftLineView;
}
- (UIView *)rightLineView {
    if (!_rightLineView) {
        _rightLineView = [UIView new];
        UIColor *lineColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        _rightLineView.backgroundColor = lineColor;
    }
    return _rightLineView;
}

@end
