//
//  WBAutoTagListView.m
//  WBAutoTagListViewDemo
//
//  Created by wenbo on 2018/6/6.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "WBAutoTagListView.h"
#import "WBTagListItem.h"
#import "Masonry.h"

@interface WBAutoTagListView () <WBTagListItemDelegate>

@property (nonatomic, strong) NSMutableArray <WBTagListItem *>*itemArray;

@end

@implementation WBAutoTagListView

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
    _secionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    _minimumLineSpacing = 15;
    _minimumInteritemSpacing = 10;
    _itemHeight = 28.f;
}

- (void)initSubviews {
    
}

- (void)configLayout {
    
}

#pragma mark < Layout >
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat maxWidth = self.bounds.size.width - _secionInset.left - _secionInset.right;
    __block CGFloat rowWidth = 0;
    __block BOOL isNeedChangeLine = YES;
    __block WBTagListItem *lastItem = nil;
    NSInteger count = self.itemArray.count;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat titleWidth = obj.titleWidth;
        rowWidth += titleWidth + _minimumInteritemSpacing;
         /** < 是否需要换行 >  */
        if (rowWidth > maxWidth - 2 * _minimumInteritemSpacing) {
            isNeedChangeLine = YES;
            /** < 判断是否超过最大值 >  */
            if (titleWidth + 2 * _minimumInteritemSpacing > maxWidth) {
                titleWidth = maxWidth - 2 * _minimumInteritemSpacing;
            }
            /** < 换行后重新设置当前行的总宽度 >  */
            rowWidth = titleWidth + _minimumInteritemSpacing;
        }
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            /** < 换行 >  */
            if (isNeedChangeLine) {
                if (!lastItem) {
                    make.top.equalTo(self.mas_top).offset(_secionInset.top);
                }else {
                    make.top.equalTo(lastItem.mas_bottom).offset(_minimumInteritemSpacing);
                }
                make.left.equalTo(self.mas_left).offset(_secionInset.left);
                isNeedChangeLine = NO;
            }else {
                make.left.equalTo(lastItem.mas_right).offset(_minimumInteritemSpacing);
                make.top.equalTo(lastItem.mas_top);
            }
            make.height.mas_equalTo(@(_itemHeight));
            make.width.mas_equalTo(@(titleWidth));
            
            /** < 最后一个 >  */
            if (idx == count - 1) {
                make.bottom.equalTo(self.mas_bottom).offset(-_secionInset.bottom);
            }
        }];
        lastItem = obj;
    }];
}

#pragma mark < Event Response >

#pragma mark < Private Method >
- (void)createTagWithData:(NSArray *)itemsArray {
    for (UIView *view in self.itemArray) {
        [view removeFromSuperview];
    }
    [self.itemArray removeAllObjects];
    for (NSInteger index = 0; index < itemsArray.count; index ++) {
        WBTagListItem *item = [WBTagListItem new];
        item.title = itemsArray[index];
        item.itemTag = index;
        item.delegate = self;
        [self addSubview:item];
        [self.itemArray addObject:item];
    }
}

#pragma mark < WBTagListItem >
- (void)wbtagListItem:(WBTagListItem *)item tagClicked:(UIButton *)sender {
    
}

#pragma mark < Getter && Setter >
- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = @[].mutableCopy;
    }
    return _itemArray;
}

- (void)setItems:(NSArray<NSString *> *)items {
    if (items.count == 0) return;
    if (_items == items) {
        /** < 已创建，直接赋值 > */
        [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.title = items[idx];
            [self setNeedsLayout];
        }];
    }else {
        [self createTagWithData:items];
    }
    _items = items;
}

- (void)setLeftMargin:(CGFloat)leftMargin {
    if (self.itemArray.count == 0) return;
    _leftMargin = leftMargin;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.leftMargin = leftMargin;
    }];
}

- (void)setBgImageName:(NSString *)bgImageName {
    if (self.itemArray.count == 0) return;
    _bgImageName = bgImageName;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bgImageName = bgImageName;
    }];
}

- (void)setSelectedBgImageName:(NSString *)selectedBgImageName {
    if (self.itemArray.count == 0) return;
    _selectedBgImageName = selectedBgImageName;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selectedBgImageName = selectedBgImageName;
    }];
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (self.itemArray.count == 0) return;
    _titleColor = titleColor;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.titleColor = titleColor;
    }];
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    if (self.itemArray.count == 0) return;
    _titleSelectedColor = titleSelectedColor;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.titleSelectedColor = titleSelectedColor;
    }];
}

- (void)setFont:(UIFont *)font {
    if (self.itemArray.count == 0) return;
    _font = font;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.font = font;
    }];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (self.itemArray.count == 0) return;
    _borderWidth = borderWidth;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.borderWidth = borderWidth;
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
