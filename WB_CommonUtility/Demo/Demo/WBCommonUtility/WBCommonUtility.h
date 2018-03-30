//
//  WBCommonUtility.h
//  Demo
//
//  Created by WMB on 2017/10/6.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kWBCOMMONUTILITY [WBCommonUtility shareManager]

UIKIT_EXTERN NSString *const kWBVersionKey;

@interface WBCommonUtility : NSObject

/**
 管理类

 @return return value description
 */
+ (instancetype)shareManager;

#pragma mark ------ < 数字转换 > ------
#pragma mark
/**
 *  将阿拉伯数字转化为中文 <系统方法>
 *
 *  @param number 阿拉伯数字
 */
- (NSString *)wb_getTheCapitalFromOfAChineseNumeralWithNumber:(NSInteger)number;
/**
 *  将阿拉伯数字转化为中文 <强制转换>
 *
 *  @param arabStr 阿拉伯数字
 */
- (NSString *)wb_chineseWithArabString:(NSString *)arabStr;
/**
 *  将金额转化为 ¥0.12 格式
 *
 *  @param money 金额
 */
- (NSString *)wb_getMoneyFormatterWithMoney:(double)money;

#pragma mark ------ < 获取聊天显示时间 > ------
#pragma mark
- (NSString *)wb_getMessageDateStringFromTimeInterval:(NSTimeInterval)TimeInterval
                                          andNeedTime:(BOOL)needTime;

#pragma mark ------ < 基础方法 > ------
#pragma mark
/**  < 拆分整数 >  */
- (NSArray *)getNumberArrayWithNumbers:(NSInteger)number;

@end
