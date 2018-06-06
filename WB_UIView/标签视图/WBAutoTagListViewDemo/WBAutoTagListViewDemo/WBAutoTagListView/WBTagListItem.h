//
//  WBTagListItem.h
//  WBAutoTagListViewDemo
//
//  Created by wenbo on 2018/6/6.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTagListItem;
@protocol WBTagListItemDelegate <NSObject>

/** < 点击item > */
- (void)didClickedItem:(WBTagListItem *)item;

@end

@interface WBTagListItem : UIView

/** < 左右间距 默认：10.f > */
@property (nonatomic, assign) CGFloat leftRightMargin;
/** < 标题 > */
@property (nonatomic, copy) NSString *title;
/** < 标记 > */
@property (nonatomic, assign) NSInteger itemTag;
/** < 标题大小 默认：14pt > */
@property (nonatomic, strong) UIFont *font;
/** < 标签颜色 默认：浅灰色 > */
@property (nonatomic, strong) UIColor *titleColor;
/** < 按钮选中颜色 > */
@property (nonatomic, strong) UIColor *titleSelectedColor;
/** < 标签背景色 默认：白色 > */
@property (nonatomic, strong) UIColor *bgColor;
/** < 背景图片 > */
@property (nonatomic, copy) NSString *bgImageName;
/** < 选中背景图片 > */
@property (nonatomic, copy) NSString *selectedBgImageName;
/** < 边框宽度 默认：0 > */
@property (nonatomic, assign) CGFloat borderWidth;
/** < 边框颜色 bodoerWidth > 0 设置有效 > */
@property (nonatomic, strong) UIColor *borderColor;
/** < 选中边框颜色 bodoerWidth > 0 设置有效 > */
@property (nonatomic, strong) UIColor *selectedBorderColor;
/** < 圆角大小 默认：0 > */
@property (nonatomic, assign) CGFloat cornerRadius;
/** < 是否选中 默认：NO > */
@property (nonatomic, assign) BOOL isSelected;

/** < 文字宽度 > */
@property (nonatomic, assign, readonly) CGFloat titleWidth;
@property (nonatomic, weak) id <WBTagListItemDelegate> delegate;

@end
