//
//  WBTabBarConfigModel.h
//  Start
//
//  Created by WenBo on 2019/10/14.
//  Copyright © 2019 jmw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBTabBarItem;

//凸出按钮形状
typedef NS_ENUM(NSInteger, WBTabBarPlusItemStyle) {
    WBTabBarPlusBtnStyleNormal,     //默认
    WBTabBarPlusBtnStyleCircular,   //圆形
    WBTabBarPlusBtnStyleSquuare     //方形
};

//item对齐方式
typedef NS_ENUM(NSInteger, WBTabBarAlignmentStyle) {
    WBTabBarAlignmentStyleCenter,       //中间对齐 默认
    WBTabBarAlignmentStyleTop,          //顶部对齐
    WBTabBarAlignmentStyleLeft,         //左对齐
    WBTabBarAlignmentStyleRight,        //右对齐
    WBTabBarAlignmentStyleBottom,       //下对齐
    WBTabBarAlignmentStyleTopLeft,      //上左对齐
    WBTabBarAlignmentStyleTopRight,     //上右对齐
    WBTabBarAlignmentStyleBottomLeft,   //下左
    WBTabBarAlignmentStyleBottomRight   //下右
};

//item内部对局
typedef NS_ENUM(NSInteger, WBTabBarItemAlignmentStyle) {
    WBTabBarItemAlignmentStyleTopImageBottomTitle,
    WBTabBarItemAlignmentStyleTopTitleBottomImage,
    WBTabBarItemAlignmentStyleLeftImageRightTitle,
    WBTabBarItemAlignmentStyleLeftTitleRightImage,
    WBTabBarItemAlignmentStyleImage,
    WBTabBarItemAlignmentStyleTitle
};

//角标位置
typedef NS_ENUM(NSInteger, WBTabBarBadgeAlignmentStyle) {
    WBTabBarBadgeAlignmentStyleTopRight,    //左上 默认
    WBTabBarBadgeAlignmentStyleTopCenter,
    WBTabBarBadgeAlignmentStyleTopLeft
};

//item点击动画效果
typedef NS_ENUM(NSInteger, WBTabBarItemAnimationStyle) {
    WBTabBarItemAnimationStyleNone,
    WBTabBarItemAnimationStyleSpring,
    WBTabBarItemAnimationStyleShake,
    WBTabBarItemAnimationStyleAlpha,
    WBTabBarItemAnimationStyleCustom
};

NS_ASSUME_NONNULL_BEGIN

typedef void(^WBTabBarItemCustomAnimationBlock)(WBTabBarItem *tabBarItem);

@interface WBTabBarConfigModel : NSObject

#pragma mark - 标题控制类
// item的标题
@property(nonatomic, copy)NSString *itemTitle;
// 默认标题颜色 默认灰色
@property (nonatomic, strong) UIColor *normalColor;
// 选中标题颜色 默认AxcAE_TabBarItemSlectBlue
@property (nonatomic, strong) UIColor *selectColor;

#pragma mark - 图片控制类
// 选中后的图片名称
@property(nonatomic, copy) NSString *selectImageName;
// 正常的图片名称
@property(nonatomic, copy) NSString *normalImageName;
// 默认的 图片tintColor
@property(nonatomic, strong) UIColor *normalTintColor;
// 选中的 图片tintColor
@property(nonatomic, strong) UIColor *selectTintColor;

#pragma mark - item背景控制类
// 默认的 按钮背景Color 默认无
@property(nonatomic, strong) UIColor *normalBackgroundColor;
// 选中的 按钮背景Color 默认无
@property(nonatomic, strong) UIColor *selectBackgroundColor;
// 单个item的背景图
@property(nonatomic, strong) UIImageView *backgroundImageView;

#pragma mark - item附加控制类
// 凸出形变类型
@property(nonatomic, assign) WBTabBarPlusItemStyle plusItemStyle;
// 凸出高于TabBar多高 默认20
@property(nonatomic, assign) CGFloat plusItemHeight;
// 突出后圆角 默认0  如果是圆形的圆角，则会根据设置的ItemSize最大宽度自动裁切，设置后将按照此参数进行裁切
@property(nonatomic, assign) CGFloat bulgeRoundedCorners;
// item相对TabBar对齐模式
@property(nonatomic, assign) WBTabBarAlignmentStyle alignmentStyle;
// item大小
@property(nonatomic, assign) CGSize itemSize;
// 角标内容
@property(nonatomic, strong) NSString *badge;
// 角标方位
@property(nonatomic, assign) WBTabBarBadgeAlignmentStyle itemBadgeStyle;
// 为零是否自动隐藏 默认不隐藏
@property(nonatomic, assign)BOOL automaticHidden;

#pragma mark - item内部组件控制类
// TitleLabel指针
@property (nonatomic, strong) UILabel *titleLabel;
// imageView
@property (nonatomic, strong) UIImageView *icomImgView;
// item内部组件布局模式
@property(nonatomic, assign) WBTabBarItemAlignmentStyle itemLayoutStyle;
// titleLabel大小 有默认值
@property(nonatomic, assign) CGSize titleLabelSize;
// icomImgView大小 有默认值
@property(nonatomic, assign) CGSize icomImgViewSize;
// 所有组件距离item边距 默认 UIEdgeInsetsMake(5, 5, 10, 5)
@property(nonatomic, assign) UIEdgeInsets componentMargin;
// 图片文字的间距 默认 2
@property(nonatomic, assign) CGFloat imageTextMargin;

#pragma mark - item交互控制类
// 点击触发后的交互效果
@property(nonatomic, assign) WBTabBarItemAnimationStyle interactionEffectStyle;
// 是否允许重复点击触发动画 默认NO
@property(nonatomic, assign)BOOL isRepeatClick;
// 当交互效果选选择自定义时，会回调以下Block
@property(nonatomic, copy) WBTabBarItemCustomAnimationBlock customInteractionEffectBlock;
// 多个自定义时候使用区分的Tag
@property(nonatomic, assign)NSInteger tag;

@end

NS_ASSUME_NONNULL_END
