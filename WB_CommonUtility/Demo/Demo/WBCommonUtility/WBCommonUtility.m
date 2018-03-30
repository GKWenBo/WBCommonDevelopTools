//
//  WBCommonUtility.m
//  Demo
//
//  Created by WMB on 2017/10/6.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBCommonUtility.h"

#import "NSArray+WBAdditional.h"

static WBCommonUtility *manager = nil;
@implementation WBCommonUtility

+ (instancetype)shareManager {
    if (!manager) {
        manager = [[self alloc]init];
    }
    return manager;
}

#pragma mark ------ < 数字转换 > ------
#pragma mark
/**
 *  将阿拉伯数字转化为中文
 *
 *  @param number 阿拉伯数字
 */
- (NSString *)wb_getTheCapitalFromOfAChineseNumeralWithNumber:(NSInteger)number {
    
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    /**  拼写  */
    formatter.numberStyle = NSNumberFormatterSpellOutStyle;
    NSString * numberStr = [formatter stringFromNumber:[NSNumber numberWithInteger:number]];
    return numberStr;
}

- (NSString *)wb_getMoneyFormatterWithMoney:(double)money {
    
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    /** 金额：¥0.12  */
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    
    NSString * numberStr = [formatter stringFromNumber:[NSNumber numberWithDouble:money]];
    return numberStr;
}

- (NSString *)wb_chineseWithArabString:(NSString *)arabStr {
    NSArray *arab_numbers = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_strs = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"〇"];
    NSArray *digits = @[@"", @"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *tranDict = [NSDictionary dictionaryWithObjects:chinese_strs forKeys:arab_numbers];
    NSString *chineseStr = @"";
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < arabStr.length; i++) {
        NSString *subStr = [arabStr substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [tranDict objectForKey:subStr];
        NSString *b = digits[arabStr.length - i - 1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_strs[9]]) {
            if ([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]]) {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_strs[9]]) {
                    [sums removeLastObject];
                }
            } else {
                sum = chinese_strs[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum]) {
                continue;
            }
        }
        [sums addObject:sum];
    }
    chineseStr = [sums componentsJoinedByString:@""];
    
    return chineseStr;
}

#pragma mark ------ < 获取聊天显示时间 > ------
#pragma mark
- (NSString *)wb_getMessageDateStringFromTimeInterval:(NSTimeInterval)TimeInterval
                                          andNeedTime:(BOOL)needTime {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:TimeInterval];
    return [self getMessageDateString:date andNeedTime:needTime];
}

- (NSString*)getMessageDateString:(NSDate*)messageDate andNeedTime:(BOOL)needTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    /**  < 消除警告宏 >  */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    /**  < 有警告的代码 >  */
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:messageDate];
    NSDate *msgDate = [cal dateFromComponents:components];
    
    NSString *weekday = [self getWeekdayWithNumber:components.weekday];
    
    components = [cal components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
#pragma clang diagnostic pop
    if([today isEqualToDate:msgDate]){
        if (needTime) {
            [formatter setDateFormat:@"今天 HH:mm"];
        }
        else{
            [formatter setDateFormat:@"今天"];
        }
        return [formatter stringFromDate:messageDate];
    }
    
    components.day -= 1;
    NSDate *yestoday = [cal dateFromComponents:components];
    if([yestoday isEqualToDate:msgDate]){
        if (needTime) {
            [formatter setDateFormat:@"昨天 HH:mm"];
        }
        else{
            [formatter setDateFormat:@"昨天"];
        }
        return [formatter stringFromDate:messageDate];
    }
    
    for (int i = 1; i <= 6; i++) {
        components.day -= 1;
        NSDate *nowdate = [cal dateFromComponents:components];
        if([nowdate isEqualToDate:msgDate]){
            if (needTime) {
                [formatter setDateFormat:[NSString stringWithFormat:@"%@ HH:mm",weekday]];
            }
            else{
                [formatter setDateFormat:[NSString stringWithFormat:@"%@",weekday]];
            }
            return [formatter stringFromDate:messageDate];
        }
    }
    while (1) {
        components.day -= 1;
        NSDate *nowdate = [cal dateFromComponents:components];
        if ([nowdate isEqualToDate:msgDate]) {
            if (!needTime) {
                [formatter setDateFormat:@"YYYY/MM/dd"];
            }
            return [formatter stringFromDate:messageDate];
            break;
        }
    }
}

//1代表星期日、如此类推
- (NSString *)getWeekdayWithNumber:(NSInteger)number
{
    switch (number) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            return @"";
            break;
    }
}

#pragma mark ------ < 基础方法 > ------
#pragma mark
- (NSArray *)getNumberArrayWithNumbers:(NSInteger)number {
    NSMutableArray *array = @[].mutableCopy;
    while (number > 0) {
        NSInteger num = number % 10;
        [array addObject:@(num)];
        number /= 10;
    }
    [array wb_reverse];
    return array;
}



@end
