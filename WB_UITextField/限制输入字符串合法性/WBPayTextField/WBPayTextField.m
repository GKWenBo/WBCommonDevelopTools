//
//  WB_PayTextField.m
//  保证金额输入合法性
//
//  Created by WMB on 2017/5/15.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBPayTextField.h"

@interface WBPayTextField ()

@property (nonatomic, strong) WBPayMoneyTextFieldLimit *limit;

@end

@implementation WBPayTextField

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
    self.delegate = self.limit;
    [self addTarget:self.limit
             action:@selector(valueChange:)
   forControlEvents:UIControlEventEditingChanged];
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self configUI];
    
}

#pragma mark -- 禁止 粘贴、剪切、选择、选择全部
#pragma mark
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (action == @selector(paste:)) {
        return NO;
    }
    
    if (action == @selector(cut:)) {
        return NO;
    }
    
    if (action == @selector(copy:)) {
        return NO;
    }
    
    if (action == @selector(select:)) {
        return NO;
    }
    
    if (action == @selector(selectAll:)) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
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

#pragma mark -- Lazy Loading
#pragma mark
- (WBPayMoneyTextFieldLimit *)limit{
    if (!_limit) {
        _limit = [[WBPayMoneyTextFieldLimit alloc] init];
    }
    return _limit;
}


@end
