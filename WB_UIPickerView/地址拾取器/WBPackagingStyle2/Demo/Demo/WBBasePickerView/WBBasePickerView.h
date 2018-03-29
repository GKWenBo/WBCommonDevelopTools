//
//  WB_BasePickerView.h
//  WB_BasePickerViewDemo
//
//  Created by Admin on 2017/7/13.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBUIConst.h"
#import "UIView+WBFrame.h"
/** 弹出位置 */
typedef NS_ENUM(NSInteger,WBPickerContentMode) {
    WBPickerContentModeCenter,
    WBPickerContentModeBottom
};
NS_ASSUME_NONNULL_BEGIN
@interface WBBasePickerView : UIButton
/** 容器视图 */
@property (nonatomic, strong) UIView *contentView;
/** 上分割线 */
@property (nonatomic, strong) UIView *topLineView;
/** 线分割线 */
@property (nonatomic, strong) UIView *bottomLineView;
/** 通用拾取器 */
@property (nonatomic, strong) UIPickerView *pickerView;
/** 标题 默认为nil */
@property (nonatomic, strong, nullable) NSString *title;
/** 设置按钮图片 */
@property (nonatomic, strong) NSString *cancelImage;
@property (nonatomic, strong) NSString *confirmImage;
/** 模糊效果图片 */
@property (nonatomic, strong) UIImage *effectImage;
/** 分割线颜色 */
@property (nonatomic, strong) UIColor *lineColor;
/** 标题颜色 */
@property (nonatomic, strong, null_resettable) UIColor *titleColor;
/** 字体大小 默认系统字体 17 */
@property (nonatomic, strong, null_resettable) UIFont *font;
/** 容器视图高度 默认240 */
@property (nonatomic, assign) CGFloat contentHeight;
/** 显示模式 */
@property (nonatomic, assign) WBPickerContentMode contentMode;
/** 弹出动画时间 默认0.25*/
@property (nonatomic, assign) NSTimeInterval showTimeInterval;
/** 移除动画时间 默认0.15 */
@property (nonatomic, assign) NSTimeInterval dismissimeInterval;

/**
 创建视图
 */
- (void)setupUI;

/**
 确认按钮点击
 */
- (void)confirmBtnClicked;

/**
 显示视图
 */
- (void)show;

/** 移除视图 */
- (void)dismiss;

@end
NS_ASSUME_NONNULL_END
