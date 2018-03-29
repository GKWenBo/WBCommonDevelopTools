//
//  ViewController.m
//  WB_LimitInputTextView
//
//  Created by Admin on 2017/7/20.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "UIView+WB_Frame.h"
#import "UITextView+Placeholder.h"
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

static CGFloat const kTextViewHeight = 50.f;
static NSInteger const kMaxTextCount = 100;
@interface ViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
/** 文字个数提示 */
@property (nonatomic, strong) UILabel *textNumberLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.textView];
    [self.textView addSubview:self.textNumberLabel];
}

#pragma mark -- UITextViewDelegate
#pragma mark
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"当前输入框文字个数：%ld",self.textView.text.length);
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.textView.text.length,kMaxTextCount];
    if (self.textView.text.length > kMaxTextCount) {
        self.textNumberLabel.textColor = [UIColor redColor];
    }else {
        self.textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    [self updateTextViewHeight];
    return YES;
}

/** 文本框每次输入文字都会调用  -> 更改文字个数提示框 */
- (void)textViewDidChangeSelection:(UITextView *)textView {
    NSLog(@"当前输入框文字个数：%ld",self.textView.text.length);
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.textView.text.length,kMaxTextCount];
    if (self.textView.text.length > kMaxTextCount) {
        self.textNumberLabel.textColor = [UIColor redColor];
    }else {
        self.textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    [self updateTextViewHeight];
}

#pragma mark -- Private Method
#pragma mark
- (void)updateTextViewHeight {
    /** 获取原始frame */
    CGFloat originHeight = self.textView.wb_height;
    /** 获取尺寸 */
    CGSize size = [self.textView sizeThatFits:CGSizeMake(self.textView.wb_width, MAXFLOAT)];
    originHeight = size.height + 15;
    /** 如果文本框没字了恢复初始尺寸 */
    if (originHeight > kTextViewHeight) {
        self.textView.wb_height = originHeight;
    }else {
        self.textView.wb_height = kTextViewHeight;
    }
    self.textNumberLabel.wb_top = self.textView.wb_height - 15 - 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Getter And Setter
#pragma mark
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, kTextViewHeight)];
        _textView.font = [UIFont systemFontOfSize:15.f];
        _textView.placeholder = @"说出你的想法吧~";
        _textView.layer.borderWidth = 1.f;
        _textView.layer.borderColor = [UIColor orangeColor].CGColor;
        _textView.delegate = self;
    }
    return _textView;
}

- (UILabel *)textNumberLabel {
    if (!_textNumberLabel) {
        _textNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.textView.wb_height - 15 - 5, SCREEN_WIDTH - 10, 15)];
        _textNumberLabel.font = [UIFont systemFontOfSize:14.f];
        _textNumberLabel.textAlignment = NSTextAlignmentRight;
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        _textNumberLabel.backgroundColor = [UIColor clearColor];
        _textNumberLabel.text = [NSString stringWithFormat:@"0/%ld",(long)kMaxTextCount];
    }
    return _textNumberLabel;
}

@end
