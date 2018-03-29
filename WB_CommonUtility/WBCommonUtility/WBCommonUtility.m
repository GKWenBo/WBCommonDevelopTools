//
//  WBCommonUtility.m
//  Demo
//
//  Created by WMB on 2017/10/6.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBCommonUtility.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

NSString *const kWBVersionKey = @"kWBVersionKey";

#import "NSArray+WBAdditional.h"

static WBCommonUtility *manager = nil;
@implementation WBCommonUtility

+ (instancetype)shareManager {
    if (!manager) {
        manager = [[self alloc]init];
    }
    return manager;
}

#pragma mark ------ < 隐藏键盘 > ------
#pragma mark
- (UIView *)wb_findFirstResponderInView:(UIView *)view {
    for (UIView *childView in view.subviews) {
        if ([childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder]) {
            return childView;
        }
        UIView *result = [self wb_findFirstResponderInView:childView];
        if (result) {
            return result;
        }
    }
    return nil;
}
- (void)wb_dismissKeyBoardInView:(UIView *)view {
    [[self wb_findFirstResponderInView:view] resignFirstResponder];
}

#pragma mark ------ < 获取当前视图控制器 > ------
#pragma mark
- (UIViewController *)wb_getCurrentDisplayController {
    __block UIWindow *normalWindow = [[UIApplication sharedApplication] keyWindow];
    NSArray *windows = [[UIApplication sharedApplication] windows];
    if (normalWindow.windowLevel != UIWindowLevelNormal) {
        [windows enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.windowLevel == UIWindowLevelNormal) {
                normalWindow = obj;
                *stop        = YES;
            }
        }];
    }
    return [self wb_getTopViewController:normalWindow.rootViewController];
}

- (UIViewController *)wb_getTopViewController:(UIViewController *)inViewController {
    while (inViewController.presentedViewController) {
        inViewController = inViewController.presentedViewController;
    }
    if ([inViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedVC = [self wb_getTopViewController:((UITabBarController *)inViewController).selectedViewController];
        return selectedVC;
    } else if ([inViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *selectedVC = [self wb_getTopViewController:((UINavigationController *)inViewController).visibleViewController];
        return selectedVC;
    } else {
        return inViewController;
    }
}

- (UIViewController *)wb_getParentControllerFromView:(UIView *)view {
    UIResponder *responder = [view nextResponder];
    while (responder)
    {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
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

#pragma mark ------ < 创建文件名  > ------
#pragma mark
- (NSString *)wb_stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

- (NSString *)wb_createFileName {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags  = NSCalendarUnitYear|
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    NSDateComponents* dayComponents = [calendar components:(unitFlags) fromDate:date];
    NSUInteger year = [dayComponents year];
    NSUInteger month =  [dayComponents month];
    NSUInteger day =  [dayComponents day];
    NSInteger hour =  [dayComponents hour];
    NSInteger minute =  [dayComponents minute];
    double second = [dayComponents second];
    
    NSString *strMonth;
    NSString *strDay;
    NSString *strHour;
    NSString *strMinute;
    NSString *strSecond;
    if (month < 10) {
        strMonth = [NSString stringWithFormat:@"0%lu",(unsigned long)month];
    }
    else {
        strMonth = [NSString stringWithFormat:@"%lu",(unsigned long)month];
    }
    //NSLog(@"%@",strMonth.description);
    if (day < 10) {
        strDay = [NSString stringWithFormat:@"0%lu",(unsigned long)day];
    }
    else {
        strDay = [NSString stringWithFormat:@"%lu",(unsigned long)day];
    }
    
    if (hour < 10) {
        strHour = [NSString stringWithFormat:@"0%ld",(long)hour];
    }
    else {
        strHour = [NSString stringWithFormat:@"%ld",(long)hour];
    }
    
    if (minute < 10) {
        strMinute = [NSString stringWithFormat:@"0%ld",(long)minute];
    }
    else {
        strMinute = [NSString stringWithFormat:@"%ld",(long)minute];
    }
    
    if (second < 10) {
        strSecond = [NSString stringWithFormat:@"0%0.f",second];
    }
    else {
        strSecond = [NSString stringWithFormat:@"%0.f",second];
    }
    
    NSString *str = [NSString stringWithFormat:@"%ld%@%@%@%@%@%@",
                     (unsigned long)year,strMonth,strDay,strHour,strMinute,strSecond,[self wb_stringWithUUID]];
    return str;
}

#pragma mark ------ < 获取设备信息相关 > ------
#pragma mark
- (NSString *)wb_getAppName {
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    return appName;
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

#pragma mark ------ < 系统相机相关 > ------
#pragma mark
- (UIImagePickerController *)wb_imagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    [controller setSourceType:sourceType];
    [controller setMediaTypes:@[(NSString *)kUTTypeImage]];
    return controller;
}

- (BOOL)wb_isAvailablePhotoLibrary {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)wb_isAvailableCamera {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)wb_isSupportTakingPhotos {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)wb_isSupportPickPhotosFromPhotoLibrary {
    return [self wb_isSupportsMedia:(__bridge NSString *)kUTTypeImage
                      sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)wb_isSupportsMedia:(NSString *)mediaType
                sourceType:(UIImagePickerControllerSourceType)sourceType {
    __block BOOL result = NO;
    if ([mediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:mediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
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

#pragma mark ------ < 第一次启动程序 > ------
#pragma mark
- (BOOL)wb_isNeedGuide {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![[userDefaults objectForKey:kWBVersionKey] isEqualToString:version]) {
        [userDefaults setObject:version forKey:kWBVersionKey];
        [userDefaults synchronize];
        return YES;;
    }
    return NO;
}

@end
