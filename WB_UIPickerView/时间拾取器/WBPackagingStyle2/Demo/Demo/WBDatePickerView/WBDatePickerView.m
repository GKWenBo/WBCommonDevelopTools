//
//  WB_DatePickerView.m
//  WB_DatePickerViewDemo1
//
//  Created by Admin on 2017/7/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBDatePickerView.h"
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

static NSInteger const MAX_YEAR = 9999;
static NSInteger const MIN_YEAR = 0;
@interface WBDatePickerView () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString * dateFormatter;
    /** 记录位置 */
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    NSInteger hourIndex;
    NSInteger minuteIndex;
    
    NSInteger preRow;
    NSDate * startDate;
}
#pragma mark -- Property
#pragma mark
/** 日期存储数组 */
@property (strong, nonatomic) NSMutableArray *yearArray;
@property (strong, nonatomic) NSMutableArray *monthArray;
@property (strong, nonatomic) NSMutableArray *dayArray;
@property (strong, nonatomic) NSMutableArray *hourArray;
@property (strong, nonatomic) NSMutableArray *minuteArray;
@property (nonatomic, strong) NSDate *scrollToDate;/** 滚到指定日期 */
@end
@implementation WBDatePickerView

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    if (!_scrollToDate) {
        _scrollToDate = [NSDate date];
    }
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    //循环滚动时需要用到
    preRow = (self.scrollToDate.year - MIN_YEAR) * 12 + self.scrollToDate.month - 1;
    
    //设置年月日时分数据
    //设置年月日时分数据
    _yearArray = [self setArray:_yearArray];
    _monthArray = [self setArray:_monthArray];
    _dayArray = [self setArray:_dayArray];
    _hourArray = [self setArray:_hourArray];
    _minuteArray = [self setArray:_minuteArray];
    for (int i=0; i<60; i++) {
        NSString *num = [NSString stringWithFormat:@"%02d",i];
        if (0<i && i<=12)
            [_monthArray addObject:num];
        if (i<24)
            [_hourArray addObject:num];
        [_minuteArray addObject:num];
    }
    for (NSInteger i=MIN_YEAR; i<MAX_YEAR; i++) {
        NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
        [_yearArray addObject:num];
    }
    
    //最大最小限制
    if (!self.maxLimitDate) {
        self.maxLimitDate = [NSDate date:@"9999-12-31 23:59" WithFormat:@"yyyy-MM-dd HH:mm"];
    }
    //最小限制
    if (!self.minLimitDate) {
        self.minLimitDate = [NSDate date:@"0000-01-01 00:00" WithFormat:@"yyyy-MM-dd HH:mm"];
    }
}

#pragma mark -- UIPickerViewDelegate,UIPickerViewDataSource
#pragma mark
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (self.datePickerStyle) {
        case WB_ShowDateYearMonthDayHourMinuteStyle:
            [self addLabelWithName:@[@"年",@"月",@"日",@"时",@"分"]];
            return 5;
            break;
        case WB_ShowDateMonthDayHourMinuteStyle:
             [self addLabelWithName:@[@"月",@"日",@"时",@"分"]];
            return 4;
            break;
        case WB_ShowDateYearMonthDayStyle:
            [self addLabelWithName:@[@"年",@"月",@"日"]];
            return 3;
            break;
        case WB_ShowDateMonthDayStyle:
            [self addLabelWithName:@[@"月",@"日"]];
            return 2;
            break;
        case WB_ShowDateHourMinuteStyle:
            [self addLabelWithName:@[@"时",@"分"]];
            return 2;
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *numberArr = [self getNumberOfRowsInComponent];
    return [numberArr[component] integerValue];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:17]];
    }
    NSString * title;
    switch (self.datePickerStyle) {
        case WB_ShowDateYearMonthDayHourMinuteStyle:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            if (component==2) {
                title = _dayArray[row];
            }
            if (component==3) {
                title = _hourArray[row];
            }
            if (component==4) {
                title = _minuteArray[row];
            }
            break;
        case WB_ShowDateYearMonthDayStyle:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            if (component==2) {
                title = _dayArray[row];
            }
            break;
        case WB_ShowDateMonthDayHourMinuteStyle:
            if (component==0) {
                title = _monthArray[row%12];
            }
            if (component==1) {
                title = _dayArray[row];
            }
            if (component==2) {
                title = _hourArray[row];
            }
            if (component==3) {
                title = _minuteArray[row];
            }
            break;
        case WB_ShowDateMonthDayStyle:
            if (component==0) {
                title = _monthArray[row%12];
            }
            if (component==1) {
                title = _dayArray[row];
            }
            break;
        case WB_ShowDateHourMinuteStyle:
            if (component==0) {
                title = _hourArray[row];
            }
            if (component==1) {
                title = _minuteArray[row];
            }
            break;
        default:
            title = @"";
            break;
    }
    customLabel.text = title;
    customLabel.textColor = [UIColor blackColor];
    return customLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (self.datePickerStyle) {
        case WB_ShowDateYearMonthDayHourMinuteStyle:{
            if (component == 0) {
                yearIndex = row;
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 3) {
                hourIndex = row;
            }
            if (component == 4) {
                minuteIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
                
            }
        }
            break;
        case WB_ShowDateYearMonthDayStyle:{
            if (component == 0) {
                yearIndex = row;
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }

        }
            break;
        case WB_ShowDateMonthDayHourMinuteStyle:{
            if (component == 1) {
                dayIndex = row;
            }
            if (component == 2) {
                hourIndex = row;
            }
            if (component == 3) {
                minuteIndex = row;
            }
            
            if (component == 0) {
                
                [self yearChange:row];
                
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
            [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
        }
            break;
        case WB_ShowDateMonthDayStyle:{
            if (component == 1) {
                dayIndex = row;
            }
            if (component == 0) {
                
                [self yearChange:row];
                
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
            [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
        }
            break;
            
        case WB_ShowDateHourMinuteStyle:{
            if (component == 0) {
                hourIndex = row;
            }
            if (component == 1) {
                minuteIndex = row;
            }
        }
            break;
        default:
            break;
    }
    [pickerView reloadAllComponents];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",_yearArray[yearIndex],_monthArray[monthIndex],_dayArray[dayIndex],_hourArray[hourIndex],_minuteArray[minuteIndex]];
    
    self.scrollToDate = [[NSDate date:dateStr WithFormat:@"yyyy-MM-dd HH:mm"] dateWithFormatter:dateFormatter];
    
    if ([self.scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        self.scrollToDate = self.minLimitDate;
        [self getNowDate:self.minLimitDate animated:YES];
    }else if ([self.scrollToDate compare:self.maxLimitDate] == NSOrderedDescending){
        self.scrollToDate = self.maxLimitDate;
        [self getNowDate:self.maxLimitDate animated:YES];
    }
    startDate = self.scrollToDate;
}

#pragma mark -- Private Method
#pragma mark
- (NSMutableArray *)setArray:(id)mutableArray
{
    if (mutableArray)
        [mutableArray removeAllObjects];
    else
        mutableArray = [NSMutableArray array];
    return mutableArray;
}

- (NSArray *)getNumberOfRowsInComponent {
    NSInteger yearNum = _yearArray.count;
    NSInteger monthNum = _monthArray.count;
    NSInteger dayNum = [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
    NSInteger hourNum = _hourArray.count;
    NSInteger minuteNum = _minuteArray.count;
    
    NSInteger timeInterval = MAX_YEAR - MIN_YEAR;
    
    switch (self.datePickerStyle) {
        case WB_ShowDateYearMonthDayHourMinuteStyle:
            return @[@(yearNum),@(monthNum),@(dayNum),@(hourNum),@(minuteNum)];
            break;
        case WB_ShowDateMonthDayHourMinuteStyle:
            return @[@(monthNum*timeInterval),@(dayNum),@(hourNum),@(minuteNum)];
            break;
        case WB_ShowDateYearMonthDayStyle:
            return @[@(yearNum),@(monthNum),@(dayNum)];
            break;
        case WB_ShowDateMonthDayStyle:
            return @[@(monthNum*timeInterval),@(dayNum),@(hourNum)];
            break;
        case WB_ShowDateHourMinuteStyle:
            return @[@(hourNum),@(minuteNum)];
            break;
        default:
            return @[];
            break;
    }
}

//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
            [self setdayArray:31];
            return 31;
        }
        case 4:case 6:case 9:case 11:{
            [self setdayArray:30];
            return 30;
        }
        case 2:{
            if (isrunNian) {
                [self setdayArray:29];
                return 29;
            }else{
                [self setdayArray:28];
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}

//设置每月的天数数组
- (void)setdayArray:(NSInteger)num
{
    [_dayArray removeAllObjects];
    for (int i=1; i<=num; i++) {
        [_dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
}

- (void)addLabelWithName:(NSArray *)nameArr {
    for (id subView in self.pickerView.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    for (int i = 0; i < nameArr.count; i ++) {
        CGFloat labelX = self.pickerView.width / (nameArr.count * 2) + 18 + self.pickerView.width / nameArr.count * i;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, self.pickerView.height / 2 - 15 / 2.0, 15, 15)];
        label.text = nameArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.textColor =  RGB_COLOR(247, 133, 51);
        label.backgroundColor = [UIColor clearColor];
        [self.pickerView addSubview:label];
    }
}
//滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated{
    if (!date) {
        date = [NSDate date];
    }
    [self DaysfromYear:date.year andMonth:date.month];
    yearIndex = date.year - MIN_YEAR;
    monthIndex = date.month - 1;
    dayIndex = date.day - 1;
    hourIndex = date.hour;
    minuteIndex = date.minute;
    //循环滚动时需要用到
    preRow = (self.scrollToDate.year - MIN_YEAR) * 12+self.scrollToDate.month - 1;
    NSArray *indexArray;
    if (self.datePickerStyle == WB_ShowDateYearMonthDayHourMinuteStyle)
        indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex),@(hourIndex),@(minuteIndex)];
    if (self.datePickerStyle == WB_ShowDateYearMonthDayStyle)
        indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex)];
    if (self.datePickerStyle == WB_ShowDateMonthDayHourMinuteStyle)
        indexArray = @[@(monthIndex),@(dayIndex),@(hourIndex),@(minuteIndex)];
    if (self.datePickerStyle == WB_ShowDateMonthDayStyle)
        indexArray = @[@(monthIndex),@(dayIndex)];
    if (self.datePickerStyle == WB_ShowDateHourMinuteStyle)
        indexArray = @[@(hourIndex),@(minuteIndex)];
    [self.pickerView reloadAllComponents];
    
    for (int i = 0; i < indexArray.count; i ++) {
        if ((self.datePickerStyle == WB_ShowDateMonthDayHourMinuteStyle || self.datePickerStyle == WB_ShowDateMonthDayStyle)&& i == 0) {
            NSInteger mIndex = [indexArray[i] integerValue]+(12*(self.scrollToDate.year - MIN_YEAR));
            [self.pickerView selectRow:mIndex inComponent:i animated:animated];
        } else {
            [self.pickerView selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];
        }
    }
}

- (void)yearChange:(NSInteger)row {
    monthIndex = row%12;
    //年份状态变化
    if (row-preRow <12 && row-preRow>0 && [_monthArray[monthIndex] integerValue] < [_monthArray[preRow%12] integerValue]) {
        yearIndex ++;
    } else if(preRow-row <12 && preRow-row > 0 && [_monthArray[monthIndex] integerValue] > [_monthArray[preRow%12] integerValue]) {
        yearIndex --;
    }else {
        NSInteger interval = (row-preRow)/12;
        yearIndex += interval;
    }
    preRow = row;
}

#pragma mark -- Events Response
#pragma mark
- (void)confirmBtnClicked {
    [self dismiss];
    NSString * dateStr = [self.scrollToDate stringWithFormat:dateFormatter];
    startDate = [self.scrollToDate dateWithFormatter:dateFormatter];
    if (_DateSelectedBlock) {
        _DateSelectedBlock(dateStr,startDate);
    }
}
#pragma mark -- Getter And Setter
#pragma mark
- (void)setDatePickerStyle:(WB_ShowDateStyle)datePickerStyle {
    _datePickerStyle = datePickerStyle;
    switch (datePickerStyle) {
        case WB_ShowDateYearMonthDayHourMinuteStyle:
            dateFormatter = @"yyyy-MM-dd HH:mm";
            break;
        case WB_ShowDateMonthDayHourMinuteStyle:
            dateFormatter = @"yyyy-MM-dd HH:mm";
            break;
        case WB_ShowDateYearMonthDayStyle:
            dateFormatter = @"yyyy-MM-dd";
            break;
        case WB_ShowDateMonthDayStyle:
            dateFormatter = @"yyyy-MM-dd";
            break;
        case WB_ShowDateHourMinuteStyle:
            dateFormatter = @"HH:mm";
            break;
        default:
            dateFormatter = @"yyyy-MM-dd HH:mm";
            break;
    }
}

- (void)setMinLimitDate:(NSDate *)minLimitDate {
    _minLimitDate = minLimitDate;
    if ([_scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        _scrollToDate = self.minLimitDate;
    }
    [self getNowDate:self.scrollToDate animated:NO];
}

@end
