//
//  WB_TagsView.m
//  WB_TagsView
//
//  Created by WMB on 2017/9/10.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBTagsView.h"

@interface WBTagsView ()
{
    UIButton *tempButton;
}
/**
 cache tags button
 */
@property (nonatomic,strong) NSMutableArray * tagsButtonArray;
@property (nonatomic,strong) NSMutableArray * selectedTempArray;
/**  < 需要移动的矩阵 >  */
@property (nonatomic, assign) CGPoint oriCenter;
@property (nonatomic, assign) CGRect moveFinalRect;
@end

@implementation WBTagsView

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
    _tagFont = [UIFont systemFontOfSize:14.f];
    _tagTitleColor = [UIColor darkGrayColor];
    _tagsColumn = 0;
    _borderWidth = 0;
    _contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _cornerRadius = 0.f;
    _tagMargin = 10.f;
    _tagNormalBackgroundImage = [self wb_imageWithColor:[UIColor whiteColor]];
    _tagSelectedBackgroundImage = [self wb_imageWithColor:[UIColor cyanColor]];
    _allowSelected = NO;
    _allowSingleSelected = NO;
    _allMultipleSelected = NO;
    _allowDefalutSelected = NO;
}

#pragma mark --------  event response  --------
#pragma mark
- (void)tagsButtonClicked:(UIButton *)sender {
    if (_allowSelected && _allowSingleSelected && !_allMultipleSelected) {
        if (tempButton == nil) {
            sender.selected = YES;
            tempButton = sender;
            [self setupButtonBorderColorWithButton:sender isSlected:sender.selected];
            if (_delegate && [_delegate respondsToSelector:@selector(wb_tagsView:didSelectedIndex:)]) {
                [_delegate wb_tagsView:self didSelectedIndex:sender.tag];
            }
        }else if (tempButton != nil && tempButton == sender) {
            sender.selected = YES;
            [self setupButtonBorderColorWithButton:sender isSlected:sender.selected];
            if (_delegate && [_delegate respondsToSelector:@selector(wb_tagsView:didSelectedIndex:)]) {
                [_delegate wb_tagsView:self didSelectedIndex:sender.tag];
            }
        }else if (tempButton != nil && tempButton != sender) {
            tempButton.selected = NO;
            [self setupButtonBorderColorWithButton:tempButton isSlected:tempButton.selected];
            sender.selected = YES;
            if (_delegate && [_delegate respondsToSelector:@selector(wb_tagsView:didSelectedIndex:)]) {
                [_delegate wb_tagsView:self didSelectedIndex:sender.tag];
            }
            [self setupButtonBorderColorWithButton:sender isSlected:sender.selected];
            tempButton = sender;
        }
        [self.selectedTempArray removeAllObjects];
        [self.selectedTempArray addObject:tempButton.currentTitle];
    }else if (_allowSelected && _allMultipleSelected && !_allowSingleSelected) {
        sender.selected = !sender.selected;
        [self setupButtonBorderColorWithButton:sender isSlected:sender.selected];
        if (sender.selected) {
            if (_delegate && [_delegate respondsToSelector:@selector(wb_tagsView:didSelectedIndex:)]) {
                [_delegate wb_tagsView:self didSelectedIndex:sender.tag];
            }
            [self.selectedTempArray addObject:sender.currentTitle];
        }else {
            if (_delegate && [_delegate respondsToSelector:@selector(wb_tagsView:didDeselectedIndex:)]) {
                [_delegate wb_tagsView:self didDeselectedIndex:sender.tag];
            }
            [self.selectedTempArray removeObject:sender.currentTitle];
        }
    }
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * button, NSUInteger idx, BOOL * _Nonnull stop) {
        if (_tagsColumn == 0) {
            [self updateTagButtonFrame:button.tag extreMargin:YES];
        }else {
            /**  < 规律布局 >  */
            [self setupButtonFrameRegularWithButton:button];
        }
    }];
    /**  < update frame >  */
    [UIView animateWithDuration:0.f animations:^{
        CGRect frame = self.frame;
        frame.size.height = self.tagsViewHeight;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
    }];
}

#pragma mark --------  private method  --------
#pragma mark
- (void)setupButtonFrameRegularWithButton:(UIButton *)button {
    NSInteger tag = button.tag;
    NSInteger col = tag % _tagsColumn;
    NSInteger row = tag / _tagsColumn;
    CGFloat btnW = (self.bounds.size.width - _tagMargin * (_tagsColumn + 1)) / _tagsColumn;
    CGFloat btnH = [button.currentTitle wb_sizeForFont:_tagFont size:CGSizeMake(btnW, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping].height + _contentInset.top + _contentInset.bottom;
    CGFloat btnX = _tagMargin + col * (btnW + _tagMargin);
    CGFloat btnY = _tagMargin + row * (btnH + _tagMargin);
    button.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

- (void)updateTagButtonFrame:(NSInteger)i extreMargin:(BOOL)extreMargin {
    /**  < 获取上一个按钮 >  */
    NSInteger pre_tag = i - 1;
    UIButton *pre_button = nil;
    /**  < 过滤上一个角标 >  */
    if (pre_tag >= 0) {
        pre_button = self.tagsButtonArray[pre_tag];
    }
    UIButton * tagButton = self.tagsButtonArray[i];
    [self setupTagButtonCustomFrame:tagButton preButton:pre_button extreMargin:extreMargin];
}

- (void)setupTagButtonCustomFrame:(UIButton *)tagButton preButton:(UIButton *)preButton extreMargin:(BOOL)extreMargin {
    /**  < 等于上一个按钮的最大X + 间距 >  */
    CGFloat btnX = CGRectGetMaxX(preButton.frame) + _tagMargin;
    /**  < 等于上一个按钮的Y值,如果没有就是标签间距 >  */
    CGFloat btnY = preButton ? preButton.frame.origin.y : _tagMargin;
    /**  < 获取按钮宽度 >  */
    CGFloat btnW = extreMargin ? [tagButton.currentTitle wb_sizeForFont:_tagFont size:CGSizeMake(MAXFLOAT, 1000) mode:NSLineBreakByWordWrapping].width + _contentInset.left + _contentInset.right : tagButton.bounds.size.width;
    CGFloat btnH = extreMargin ? [tagButton.currentTitle wb_sizeForFont:_tagFont size:CGSizeMake(btnW, MAXFLOAT) mode:NSLineBreakByWordWrapping].height + _contentInset.top + _contentInset.bottom : tagButton.bounds.size.height;
    /**  < 判断当前按钮是否足够显示 >  */
    CGFloat rightWidth = self.bounds.size.width - btnX;
    if (rightWidth < btnW) {
        btnX = _tagMargin;
        btnY = CGRectGetMaxY(preButton.frame) + _tagMargin;
    }
    tagButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

- (void)setupButtonBorderColorWithButton:(UIButton *)button isSlected:(BOOL)isSlected {
    if (isSlected) {
        button.layer.borderColor = _borderSelectedColor.CGColor;
    }else {
        button.layer.borderColor = _borderNormalColor.CGColor;
    }
}

#pragma mark --------  UIImage  --------
#pragma mark
- (UIImage *)wb_imageWithColor:(UIColor *)color {
    
    return [self wb_imageWithColor:color size:CGSizeMake(1, 1)];
}
- (nullable UIImage *)wb_imageWithColor:(UIColor *)color
                                   size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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

- (NSMutableArray *)tagsButtonArray {
    if (!_tagsButtonArray) {
        _tagsButtonArray = @[].mutableCopy;
    }
    return _tagsButtonArray;
}

- (NSMutableArray *)selectedTempArray {
    if (!_selectedTempArray) {
        _selectedTempArray = @[].mutableCopy;
    }
    return _selectedTempArray;
}

- (CGFloat)tagsViewHeight {
    if (self.tagsArray.count == 0)return 0;
    return CGRectGetMaxY([self.tagsButtonArray.lastObject frame]) + _tagMargin;
}
- (void)setTagsArray:(NSArray<NSString *> *)tagsArray {
    _tagsArray = tagsArray;
    NSAssert(tagsArray.count > 0, @"please setup dataSource");
    [self.tagsButtonArray removeAllObjects];
    [tagsArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.adjustsImageWhenHighlighted = NO;
        button.enabled = _allowSelected;
        button.titleLabel.font = _tagFont;
        [button setTitleColor:_tagTitleColor forState:UIControlStateNormal];
        [button setBackgroundImage:_tagNormalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:_tagNormalBackgroundImage forState:UIControlStateDisabled];
        [button setBackgroundImage:_tagSelectedBackgroundImage forState:UIControlStateSelected];
        button.layer.borderWidth = _borderWidth;
        button.layer.cornerRadius = _cornerRadius;
        button.layer.masksToBounds = _cornerRadius > 0 ? YES : NO;
        button.layer.borderColor = _borderNormalColor.CGColor;
        [button setTitle:obj forState:UIControlStateNormal];
        button.tag = idx;
        [button addTarget:self action:@selector(tagsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.tagsButtonArray addObject:button];
        if (_allowDefalutSelected && _allowSelected) {
            if (idx == 0) {
                button.selected = YES;
                tempButton = button;
                if (_borderWidth > 0) {
                    [self setupButtonBorderColorWithButton:button isSlected:YES];
                }
                [self.selectedTempArray removeAllObjects];
                [self.selectedTempArray addObject:button.currentTitle];
            }
        }
    }];
    [self setNeedsLayout];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    if (cornerRadius > 0) {
        [self.tagsButtonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            button.layer.cornerRadius = cornerRadius;
            button.layer.masksToBounds = YES;
        }];
    }
}

- (void)setTagTitleColor:(UIColor *)tagTitleColor {
    if (_tagTitleColor != tagTitleColor) {
        _tagTitleColor = tagTitleColor;
        [self.tagsButtonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            [button setTitleColor:tagTitleColor forState:UIControlStateNormal];
        }];
    }
}

- (void)setTagFont:(UIFont *)tagFont {
    if (_tagFont != tagFont) {
        _tagFont = tagFont;
        [self.tagsButtonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            button.titleLabel.font = tagFont;
        }];
    }
}

- (void)setTagNormalBackgroundImage:(UIImage *)tagNormalBackgroundImage {
    if (_tagNormalBackgroundImage != tagNormalBackgroundImage) {
        _tagNormalBackgroundImage = tagNormalBackgroundImage;
        [self.tagsButtonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            [button setBackgroundImage:tagNormalBackgroundImage forState:UIControlStateNormal];
        }];
    }
}

- (void)setTagSelectedBackgroundImage:(UIImage *)tagSelectedBackgroundImage {
    if (_tagSelectedBackgroundImage != tagSelectedBackgroundImage) {
        [self.tagsButtonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            [button setBackgroundImage:tagSelectedBackgroundImage forState:UIControlStateSelected];
        }];
    }
}

- (void)setAllowSelected:(BOOL)allowSelected {
    if (_allowSelected != allowSelected) {
        _allowSelected = allowSelected;
        [self.tagsButtonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            button.enabled = allowSelected;
        }];
    }
}

- (void)setAllowDefalutSelected:(BOOL)allowDefalutSelected {
    if (_allowDefalutSelected != allowDefalutSelected) {
        _allowDefalutSelected = allowDefalutSelected;
        [self.tagsButtonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            if (allowDefalutSelected && _allowSelected) {
                if (idx == 0) {
                    button.selected = YES;
                    tempButton = button;
                    if (_borderWidth > 0) {
                        [self setupButtonBorderColorWithButton:button isSlected:YES];
                    }
                    if (_delegate && [_delegate respondsToSelector:@selector(wb_tagsView:didSelectedIndex:)]) {
                        [_delegate wb_tagsView:self didSelectedIndex:button.tag];
                    }
                    [self.selectedTempArray removeAllObjects];
                    [self.selectedTempArray addObject:button.currentTitle];
                }else {
                    [self setupButtonBorderColorWithButton:button isSlected:NO];
                }
            }
        }];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (_borderWidth != borderWidth) {
        _borderWidth = borderWidth;
        [self.tagsButtonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            button.layer.borderWidth = borderWidth;
        }];
    }
}

- (NSArray<NSString *> *)didSelectedTags {
    return self.selectedTempArray.copy;
}

- (void)setDefualtSelectedTitleArray:(NSArray *)defualtSelectedTitleArray {
    _defualtSelectedTitleArray  = defualtSelectedTitleArray;
    if (defualtSelectedTitleArray.count > 0) {
        for (NSInteger i = 0; i < defualtSelectedTitleArray.count; i ++) {
            NSString *title = defualtSelectedTitleArray[i];
            for (NSInteger j = 0; j < self.tagsButtonArray.count; j ++) {
                UIButton *button = self.tagsButtonArray[j];
                NSString *currentTitle = button.currentTitle;
                if ([title isEqualToString:currentTitle]) {
                    if (_allowSelected && _allowSingleSelected) {
                        button.selected = YES;
                        tempButton = button;
                        [self setupButtonBorderColorWithButton:button isSlected:button.selected];
                        [self.selectedTempArray removeAllObjects];
                        [self.selectedTempArray addObject:title];
                    }else {
                        button.selected = YES;
                        [self.selectedTempArray addObject:title];
                        [self setupButtonBorderColorWithButton:button isSlected:button.selected];
                    }
                }
            }
        }
    }
}

- (void)setDefaultSelectedIndexArray:(NSArray<NSNumber *> *)defaultSelectedIndexArray {
    _defaultSelectedIndexArray = defaultSelectedIndexArray;
    if (defaultSelectedIndexArray.count > 0) {
        for (NSInteger i = 0; i < defaultSelectedIndexArray.count; i ++) {
            NSInteger index = [defaultSelectedIndexArray[i] integerValue];
            for (NSInteger j = 0; j < self.tagsButtonArray.count; j ++) {
                UIButton *button = self.tagsButtonArray[j];
                NSInteger currentIndex = button.tag;
                if (index == currentIndex) {
                    if (_allowSelected && _allowSingleSelected) {
                        button.selected = YES;
                        tempButton = button;
                        [self setupButtonBorderColorWithButton:button isSlected:button.selected];
                        [self.selectedTempArray removeAllObjects];
                        [self.selectedTempArray addObject:button.currentTitle];
                    }else {
                        button.selected = YES;
                        [self.selectedTempArray addObject:button.currentTitle];
                        [self setupButtonBorderColorWithButton:button isSlected:button.selected];
                    }
                }
            }
        }
    }
}

@end

@implementation NSString (WB_CalculateSize)

#pragma mark --------  计算文字大小  --------
#pragma mark
/**
 *  计算文字size
 *
 *  @param size 限制size
 *  @param font 字体
 *  @return 文字size
 */
- (CGSize)wb_sizeForFont:(UIFont *)font
                    size:(CGSize)size
                    mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

@end
