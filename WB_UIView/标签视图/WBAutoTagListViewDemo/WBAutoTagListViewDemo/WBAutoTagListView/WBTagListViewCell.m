//
//  TableViewCell.m
//  WBAutoTagListViewDemo
//
//  Created by 文波 on 2018/6/6.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "WBTagListViewCell.h"
#import "Masonry.h"

@interface WBTagListViewCell () <WBTagListItemDelegate>
{
    WBTagListItem *_tempItem;
}
@property (nonatomic, strong) NSMutableArray <WBTagListItem *>*itemArray;


@end

@implementation WBTagListViewCell

#pragma mark < 初始化 >
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initDataSource];
        [self initSubviews];
        [self configLayout];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    [self initDataSource];
    [self initSubviews];
    [self configLayout];
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark < 数据源 >
- (void)initDataSource {
    _secionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    _minimumLineSpacing = 15;
    _minimumInteritemSpacing = 10;
    _itemHeight = 28.f;
    _allowSelection = YES;
    _allowMultipleSelection = NO;
}

#pragma mark < 初始化UI >
- (void)initSubviews {
    /** << init subviews > */
    
}

- (void)configLayout {
    /** << Configure layout > */
}

#pragma mark < Layout >
- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark < Event Response >

#pragma mark < WBTagListItemDelegate >
- (void)didClickedItem:(WBTagListItem *)item {
    if (!_allowSelection) return;
    /** < 多选 > */
    if (_allowMultipleSelection) {
        item.isSelected = !item.isSelected;
        if (item.isSelected) {
            [self.selectedItems addObject:_items[item.itemTag]];
        }else {
            [self.selectedItems removeObject:_items[item.itemTag]];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(wbtagListViewCell:selectedItem:deselectedItem:)]) {
            [_delegate wbtagListViewCell:self
                            selectedItem:item
                          deselectedItem:nil];
        }
    }else {
        /** < 单选 > */
        if (_tempItem == nil) {
            item.isSelected = YES;
            _tempItem = item;
            if (_delegate && [_delegate respondsToSelector:@selector(wbtagListViewCell:selectedItem:deselectedItem:)]) {
                [_delegate wbtagListViewCell:self
                                selectedItem:item
                              deselectedItem:nil];
            }
        }else if (_tempItem && _tempItem == item) {
            
        }else if (_tempItem && _tempItem != item) {
            _tempItem.isSelected = NO;
            item.isSelected = YES;
            if (_delegate && [_delegate respondsToSelector:@selector(wbtagListViewCell:selectedItem:deselectedItem:)]) {
                [_delegate wbtagListViewCell:self
                                selectedItem:item
                              deselectedItem:_tempItem];
            }
            _tempItem = item;
            [self.selectedItems removeAllObjects];
            [self.selectedItems addObject:_items[_tempItem.itemTag]];
        }
    }
}

#pragma mark < Private Method >
- (void)createTagWithData:(NSArray <WBTagListModel *>*)itemsArray {
    for (UIView *view in self.itemArray) {
        [view removeFromSuperview];
    }
    [self.itemArray removeAllObjects];
    
    for (NSInteger index = 0; index < itemsArray.count; index ++) {
        WBTagListItem *item = [WBTagListItem new];
        item.title = itemsArray[index].title;
        item.isSelected = itemsArray[index].isSelected;
        item.itemTag = index;
        item.delegate = self;
        [self.contentView addSubview:item];
        [self.itemArray addObject:item];
        
        /** < 默认选中第一个 > */
        if (index == 0 && itemsArray[index].isSelected) {
            _tempItem = item;
            [self.selectedItems removeAllObjects];
            [self.selectedItems addObject:_tempItem];
        }
    }
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    CGFloat maxWidth = self.contentView.bounds.size.width - _secionInset.left - _secionInset.right;
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
                    make.top.equalTo(self.contentView.mas_top).offset(_secionInset.top);
                }else {
                    make.top.equalTo(lastItem.mas_bottom).offset(_minimumLineSpacing);
                }
                make.left.equalTo(self.contentView.mas_left).offset(_secionInset.left);
                isNeedChangeLine = NO;
            }else {
                make.left.equalTo(lastItem.mas_right).offset(_minimumInteritemSpacing);
                make.top.equalTo(lastItem.mas_top);
            }
            make.height.mas_equalTo(@(_itemHeight));
            make.width.mas_equalTo(@(titleWidth));
            
            /** < 最后一个 >  */
            if (idx == count - 1) {
                make.bottom.equalTo(self.contentView.mas_bottom).offset(-_secionInset.bottom).priorityMedium();
            }
        }];
        lastItem = obj;
    }];
}

#pragma mark < Getter && Setter >
- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = @[].mutableCopy;
    }
    return _itemArray;
}

- (NSMutableArray *)selectedItems {
    if (!_selectedItems) {
        _selectedItems = @[].mutableCopy;
    }
    return _selectedItems;
}

- (void)setItems:(NSArray<WBTagListModel *> *)items {
    if (items.count == 0) return;
    if (_items == items) {
        /** < 已创建，直接赋值 > */
        [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.title = items[idx].title;
            obj.isSelected = items[idx].isSelected;
        }];
    }else {
        [self createTagWithData:items];
    }
    _items = items;
}

- (void)setLeftRightMargin:(CGFloat)leftMargin {
    if (self.itemArray.count == 0) return;
    _leftRightMargin = leftMargin;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.leftRightMargin = leftMargin;
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

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (self.itemArray.count == 0) return;
    _cornerRadius = cornerRadius;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.cornerRadius = cornerRadius;
    }];
}

- (void)setBorderColor:(UIColor *)borderColor {
    if (self.itemArray.count == 0) return;
    _borderColor = borderColor;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.borderColor = borderColor;
    }];
}

- (void)setSelectedBorderColor:(UIColor *)selectedBorderColor {
    if (self.itemArray.count == 0) return;
    _selectedBorderColor = selectedBorderColor;
    [self.itemArray enumerateObjectsUsingBlock:^(WBTagListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selectedBorderColor = selectedBorderColor;
    }];
}

@end

@implementation WBTagListModel


@end
