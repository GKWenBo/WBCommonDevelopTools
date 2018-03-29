//
//  WB_DatePickerView.h
//  WB_DatePickerViewDemo1
//
//  Created by Admin on 2017/7/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBBasePickerView.h"
#import "NSDate+WBExtension.h"
typedef NS_ENUM(NSInteger,WB_ShowDateStyle) {
    WB_ShowDateYearMonthDayHourMinuteStyle,     /** 年月日时分 */
    WB_ShowDateMonthDayHourMinuteStyle,         /** 月日分 */
    WB_ShowDateYearMonthDayStyle,               /** 年月日 */
    WB_ShowDateMonthDayStyle,                   /** 月日 */
    WB_ShowDateHourMinuteStyle                  /** 时分 */
};
@interface WBDatePickerView : WBBasePickerView

@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认9999）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认0）
@property (nonatomic, assign) WB_ShowDateStyle datePickerStyle;
/** 日期选择回调 */
@property (nonatomic,copy) void(^DateSelectedBlock)(NSString *dateStr,NSDate *date);

@end
