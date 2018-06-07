//
//  TableViewCell.h
//  WBAutoTagListViewDemo
//
//  Created by 文波 on 2018/6/6.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBTagListItem.h"

@class WBTagListModel;
@class WBTagListViewCell;

@protocol WBTagListViewCellDelegate <NSObject>

/**
 点击item回调，用于解决cell复用，更新数据源

 @param cell WBTagListViewCell
 @param item 当前点击item
 @param deselectedItem 单选取消选中item
 */
- (void)wbtagListViewCell:(WBTagListViewCell *)cell
             selectedItem:(WBTagListItem *)item
           deselectedItem:(WBTagListItem *)deselectedItem;

@end

@interface WBTagListViewCell : UITableViewCell

/** < 数据源 > */
@property (nonatomic, strong) NSArray <WBTagListModel *>*items;
/** < 内边距 默认： UIEdgeInsetsMake(15, 15, 15, 15) > */
@property (nonatomic, assign) UIEdgeInsets secionInset;
/** < 行间距 默认：15 > */
@property (nonatomic, assign) CGFloat minimumLineSpacing;
/** < item之间距离 默认：10 > */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
/** < 是否允许点击 默认：YES > */
@property (nonatomic, assign) BOOL allowSelection;
/** < 是否允许多选 默认：NO > */
@property (nonatomic, assign) BOOL allowMultipleSelection;
/** < 标签高度 默认：28.f > */
@property (nonatomic, assign) CGFloat itemHeight;

/** < 标签左右间距 默认：10.f > */
@property (nonatomic, assign) CGFloat leftRightMargin;
/** < 背景图片 > */
@property (nonatomic, copy) NSString *bgImageName;
/** < 选中背景图片 > */
@property (nonatomic, copy) NSString *selectedBgImageName;
/** < 标签颜色 默认：浅灰色 > */
@property (nonatomic, strong) UIColor *titleColor;
/** < 按钮选中颜色 > */
@property (nonatomic, strong) UIColor *titleSelectedColor;
/** < 标题大小 默认：14pt > */
@property (nonatomic, strong) UIFont *font;
/** < 边框宽度 默认：0 > */
@property (nonatomic, assign) CGFloat borderWidth;
/** < 边框颜色 bodoerWidth > 0 设置有效 > */
@property (nonatomic, strong) UIColor *borderColor;
/** < 选中边框颜色 bodoerWidth > 0 设置有效 > */
@property (nonatomic, strong) UIColor *selectedBorderColor;
/** < 圆角大小 默认：0 > */
@property (nonatomic, assign) CGFloat cornerRadius;
/** < 选中的item > */
@property (nonatomic, strong) NSMutableArray *selectedItems;

@property (nonatomic, weak) id <WBTagListViewCellDelegate> delegate;

@end

@interface WBTagListModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

@end

