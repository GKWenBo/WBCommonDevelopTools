//
//  WBTabBarItem.h
//  Start
//
//  Created by WenBo on 2019/10/14.
//  Copyright © 2019 jmw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBTabBarConfigModel;
@class WBTabBarBadge;

NS_ASSUME_NONNULL_BEGIN

@interface WBTabBarItem : UIControl

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithConfigModel:(WBTabBarConfigModel *)model;
// MARK:--------属性设置--------
// 标题
@property (nonatomic, copy) NSString *title;
// 默认标题颜色
@property (nonatomic, strong) UIColor *normalColor;
// 选中标题颜色
@property (nonatomic, strong) UIColor *selectColor;
// 默认的 Image
@property (nonatomic, strong) UIImage *normalImage;
// 选中的 Image
@property (nonatomic, strong) UIImage *selectImage;
// 默认的 图片tintColor
@property(nonatomic, strong) UIColor *normalTintColor;
// 选中的 图片tintColor
@property(nonatomic, strong) UIColor *selectTintColor;
// 默认的 按钮背景Color 默认无
@property(nonatomic, strong) UIColor *normalBackgroundColor;
// 选中的 按钮背景Color 默认无
@property(nonatomic, strong) UIColor *selectBackgroundColor;
// 单个item的背景图
@property(nonatomic, strong) UIImageView *backgroundImageView;
// 角标内容
@property(nonatomic, strong) NSString *badge;
// item的所在索引
@property(nonatomic, assign) NSInteger itemIndex;

// MARK:--------控件--------
// 选中状态
@property (nonatomic, assign) BOOL isSelect;
// imageView
@property (nonatomic, strong) UIImageView *icomImgView;
// 标题Label
@property (nonatomic, strong) UILabel *titleLabel;
// 角标Label
@property(nonatomic, strong) WBTabBarBadge *badgeLabel;

// 模型构造器
@property(nonatomic, strong) WBTabBarConfigModel *itemModel;
// 重新开始布局
- (void)wb_itemDidLayoutControl;
// 开始执行设置的动画
- (void)wb_startStrringConfigAnimation;

@end

NS_ASSUME_NONNULL_END
