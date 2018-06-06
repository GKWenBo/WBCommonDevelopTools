//
//  WBTagListItem.m
//  WBAutoTagListViewDemo
//
//  Created by wenbo on 2018/6/6.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "WBTagListItem.h"
#import "Masonry.h"

@interface WBTagListItem ()
{
    UIButton *tempBtn;
}
@property (nonatomic, strong) UIButton *tagBtn;

@end

@implementation WBTagListItem

#pragma mark < 初始化 >
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self initDataSource];
//        [self initSubviews];
//        [self configLayout];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDataSource];
        [self initSubviews];
        [self configLayout];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initDataSource];
    [self initSubviews];
    [self configLayout];
}

#pragma mark < 数据源 >

#pragma mark < 设置UI >
- (void)initDataSource {
    _font = [UIFont systemFontOfSize:14.f];
    _titleColor = [UIColor lightGrayColor];
    _titleSelectedColor = [UIColor lightGrayColor];
    _borderWidth = 0.f;
    _bgColor = [UIColor whiteColor];
    _leftMargin = 10.f;
    _cornerRadius = 0.f;
    _isSelected = NO;
}

- (void)initSubviews {
    [self addSubview:self.tagBtn];
}

- (void)configLayout {
    [self.tagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark < Layout >
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_borderWidth > 0) {
        self.tagBtn.layer.borderWidth = _borderWidth;
        self.tagBtn.layer.borderColor = _borderColor ? _borderColor.CGColor : [UIColor darkGrayColor].CGColor;
        self.tagBtn.layer.masksToBounds = YES;
        self.tagBtn.layer.cornerRadius = _cornerRadius;
    }
}

#pragma mark < Event Response >
- (void)tagBtnClicked:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(wbtagListItem:tagClicked:)]) {
        [_delegate wbtagListItem:self tagClicked:sender];
    }
}

#pragma mark < Private Method >
- (CGFloat)calculateTitleWidth {
    if (self.title.length == 0) {
        return 0.f;
    }
    return [self.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.tagBtn.titleLabel.font} context:nil].size.width + 0.5f + _leftMargin * 2;
}

#pragma mark < Getter && Setter >
- (UIButton *)tagBtn {
    if (!_tagBtn) {
        _tagBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        _tagBtn.titleLabel.font = _font;
        /** < 设置按钮颜色 > */
        [_tagBtn setTitleColor:_titleColor forState:UIControlStateNormal];
        [_tagBtn setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
        _tagBtn.backgroundColor = _bgColor;
        _tagBtn.selected = _isSelected;
        /** < 按钮标题 > */
//        [_tagBtn setTitle:@"" forState:UIControlStateNormal];
        /** < 设置图片 > */
//        [_tagBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_tagBtn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tagBtn;
}

- (CGFloat)titleWidth {
    return [self calculateTitleWidth];
}

- (void)setFont:(UIFont *)font {
    if (_font == font) return;
    _font = font;
    self.tagBtn.titleLabel.font = font;
}

- (void)setTitle:(NSString *)title {
    if (!title) return;
    _title = title;
    [self.tagBtn setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (_titleColor == titleColor) return;
    _titleColor = titleColor;
    [self.tagBtn setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    if (_titleSelectedColor == titleSelectedColor) return;
    _titleSelectedColor = titleSelectedColor;
    [self.tagBtn setTitleColor:titleSelectedColor forState:UIControlStateSelected];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (_borderWidth == borderWidth) return;
    _borderWidth = borderWidth;
    [self setNeedsLayout];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self setNeedsLayout];
}

- (void)setBgImageName:(NSString *)bgImageName {
    if (!bgImageName) return;
    _bgImageName = bgImageName;
    [self.tagBtn setImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
}

- (void)setSelectedBgImageName:(NSString *)selectedBgImageName {
    if (!selectedBgImageName) return;
    _selectedBgImageName = selectedBgImageName;
    [self.tagBtn setImage:[UIImage imageNamed:selectedBgImageName] forState:UIControlStateSelected];
}

- (void)setBgColor:(UIColor *)bgColor {
    if (_bgColor == bgColor) return;
    _bgColor = bgColor;
    [self.tagBtn setBackgroundColor:bgColor];
}

- (void)setLeftMargin:(CGFloat)leftMargin {
    if (_leftMargin == leftMargin) return;
    _leftMargin = leftMargin;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (_cornerRadius == cornerRadius) return;
    _cornerRadius = cornerRadius;
    [self setNeedsLayout];
}

- (void)setIsSelected:(BOOL)isSelected {
    if (_isSelected == isSelected) return;
    _isSelected = isSelected;
    self.tagBtn.selected = isSelected;
}

- (void)setItemTag:(NSInteger)itemTag {
    _itemTag = itemTag;
    self.tagBtn.tag = itemTag;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
