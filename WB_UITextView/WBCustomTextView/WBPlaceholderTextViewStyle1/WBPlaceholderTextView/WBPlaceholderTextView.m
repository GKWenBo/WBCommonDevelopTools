//
//  WB_PlaceHolderTextView.m
//  WB_PlaceHolderTextView
//
//  Created by WMB on 2017/5/31.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBPlaceholderTextView.h"

static CGFloat const UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION = 0.25;

@interface WBPlaceholderTextView ()

@property (strong, nonatomic) UILabel *placeHolderLabel;

@end

@implementation WBPlaceholderTextView

#pragma mark -- 初始化
#pragma mark
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    self.placeHolder = @"";
    self.placeHoderColor = [UIColor grayColor];
    
    /**  添加通知  */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //[self configUI];
    
}

#pragma mark -- 绘图
#pragma mark

 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
     [super drawRect:rect];
     if (self.placeholder.length > 0) {
         if (!_placeHolderLabel) {
             
             _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 8, self.bounds.size.width - 10, 0)];
             _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
             _placeHolderLabel.numberOfLines = 0;
             _placeHolderLabel.font = self.font;
             _placeHolderLabel.backgroundColor = [UIColor clearColor];
             _placeHolderLabel.textColor = self.placehoderColor;
             _placeHolderLabel.alpha = .0f;
             _placeHolderLabel.tag = 999;
             [self addSubview:_placeHolderLabel];
         }
         
         _placeHolderLabel.text = self.placeholder;
         [_placeHolderLabel sizeToFit];
         [self sendSubviewToBack:_placeHolderLabel];
     }
     
     if (self.text.length == 0 && self.placeholder.length > 0) {
         [self viewWithTag:999].alpha = 1.f;
     }
}


- (void)textChanged:(NSNotification *)notification
{
    if(self.placeholder == 0)
    {
        return;
    }
    
    [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        if([[self text] length] == 0)
        {
            [[self viewWithTag:999] setAlpha:1];
        }
        else
        {
            [[self viewWithTag:999] setAlpha:0];
        }
    }];
}

#pragma mark -- Getter and Setter
#pragma mark
- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeholder = placeHolder;
    [self setNeedsDisplay];
}

- (void)setPlaceHoderColor:(UIColor *)placeHoderColor {
    _placehoderColor = placeHoderColor;
    [self setNeedsDisplay];
}

@end
