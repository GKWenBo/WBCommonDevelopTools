//
//  WB_DatePickerView.h
//  WB_DatePickerView
//
//  Created by Admin on 2017/7/13.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBUIConst.h"
#import "UIView+WBFrame.h"
/*
 屏幕宽高
 */
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
/**
 自适应大小
 */
#define AUTOLAYOUTSIZE(size) ((size) * (SCREEN_WIDTH / 375))

/*
 设置RGB颜色/设置RGBA颜色
 */
#define RGB_COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA_COLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

NS_ASSUME_NONNULL_BEGIN
/** 弹出位置 */
typedef NS_ENUM(NSInteger,WBPickerContentMode) {
    WBPickerContentModeCenter,
    WBPickerContentModeBottom
};

@class WBDatePickerView;
@protocol WB_DatePickerViewDelegate <NSObject>

- (void)wb_datePickerView:(WBDatePickerView *)wb_datePickerView dateString:(NSString *)dateString date:(NSDate *)date;

@end

@interface WBDatePickerView : UIButton
/** 容器视图 */
@property (nonatomic, strong) UIView *contentView;
/** 上割线 */
@property (nonatomic, strong) UIView *topLineView;
/** 下分割线 */
@property (nonatomic, strong) UIView *bottomLineView;
/** 标题 默认为nil */
@property (nonatomic, strong, nullable) NSString *title;
/** 设置取消按钮图片 */
@property (nonatomic, strong) NSString *cancelImage;
/** 设置确认按钮图片 */
@property (nonatomic, strong) NSString *confirmImage;
/** 模糊效果图片 */
@property (nonatomic, strong) UIImage *effectImage;
/** 分割线颜色 */
@property (nonatomic, strong) UIColor *lineColor;
/** 标题颜色 */
@property (nonatomic, strong, null_resettable) UIColor *titleColor;
/** 字体大小 默认系统字体 17 */
@property (nonatomic, strong, null_resettable) UIFont *font;
/** 显示模式 默认WBPickerContentModeBottom */
@property (nonatomic, assign) WBPickerContentMode contentMode;
/** 弹出动画时间 默认0.25*/
@property (nonatomic, assign) NSTimeInterval showTimeInterval;
/** 移除动画时间 默认0.15 */
@property (nonatomic, assign) NSTimeInterval dismissimeInterval;
/** 日期拾取器 固定高度216*/
@property (nonatomic, strong) UIDatePicker *datePickerView;
/** 最小选择时间 默认：1970-01-01 */
@property (nonatomic, strong) NSDate *minDate;
/** 最大时间 默认：9999-12-31 */
@property (nonatomic, strong) NSDate *maxDate;
/** 日期显示模式 */
@property (nonatomic, assign) UIDatePickerMode dateMode;
@property (nonatomic, assign) id<WB_DatePickerViewDelegate> delegate;
/** 选择的日期回调 */
@property (nonatomic,copy) void(^DidSelectedDateBlock)(NSString *dateString,NSDate * date);

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
