//
//  WB_PlaceHolderTextView.m
//  WB_PlaceHolderTextView
//
//  Created by Admin on 2017/7/20.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WB_PlaceHolderTextView.h"

@interface WBPlaceHolderTextView ()
@property (nonatomic, strong) UIColor *realTextColor;
@property (nonatomic, readonly) NSString *realText;

- (void)beginEditing:(NSNotification*) notification;
- (void)endEditing:(NSNotification*) notification;
@end
@implementation WBPlaceHolderTextView

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    self.realTextColor = [UIColor blackColor];
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
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
- (void) setPlaceholder:(NSString *)aPlaceholder {
    _placeholder = aPlaceholder;
    if ([self.realText isEqualToString:_placeholder]) {
        self.text = aPlaceholder;
    }
    [self endEditing:nil];
}

- (NSString *)text {
    NSString * text = [super text];
    if ([text isEqualToString:self.placeholder]) return @"";
    return text;
}
- (void)setText:(NSString *)text {
    if ([text isEqualToString:@""] || text == nil) {
        super.text = self.placeholder;
    }
    else {
        super.text = text;
    }
    if ([super.text isEqualToString:self.placeholder]) {
        self.textColor = self.placeholderColor;
    }
    else {
        self.textColor = self.realTextColor;
    }
}

- (NSString *)realText {
    return [super text];
}

- (void)beginEditing:(NSNotification*)notification {
    if ([self.realText isEqualToString:self.placeholder]) {
        super.text = nil;
        self.textColor = self.realTextColor;
    }
}

- (void)endEditing:(NSNotification*)notification {
    if ([self.realText isEqualToString:@""] || self.realText == nil) {
        super.text = self.placeholder;
        self.textColor = self.placeholderColor;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    if ([self.realText isEqualToString:self.placeholder]) {
        if ([textColor isEqual:self.placeholderColor]) [super setTextColor:textColor];
        else self.realTextColor = textColor;
    }
    else {
        self.realTextColor = textColor;
        [super setTextColor:textColor];
    }
}

#pragma mark -
#pragma mark Dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
