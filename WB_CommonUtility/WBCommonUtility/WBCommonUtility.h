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

#pragma mark -- 隐藏键盘
#pragma mark
/**
 *  寻找视图第一响应者
 *
 *  @param view 目标视图
 */
- (UIView *)wb_findFirstResponderInView:(UIView *)view;
/**
 *  隐藏键盘
 *
 *  @param view 目标视图
 */
- (void)wb_dismissKeyBoardInView:(UIView *)view;

#pragma mark ------ < 获取当前视图控制器 > ------
#pragma mark
/**  获取当前视图控制器  */
- (UIViewController *)wb_getCurrentDisplayController;
/**  获取最上层控制器  */
- (UIViewController *)wb_getTopViewController:(UIViewController *)inViewController;

/**
 获取视图父控制器

 @param view 视图
 @return UIViewController
 */
- (UIViewController *)wb_getParentControllerFromView:(UIView *)view;

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

#pragma mark ------ < 创建文件名 > ------
#pragma mark
/**
 Returns a new UUID NSString
 e.g. "D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
 */
- (NSString *)wb_stringWithUUID;

/**
 创建文件名
 
 @return 文件名
 */
- (NSString *)wb_createFileName;

#pragma mark ------ < 获取设备信息相关 > ------
#pragma mark
- (NSString *)wb_getAppName;

#pragma mark ------ < 获取聊天显示时间 > ------
#pragma mark
- (NSString *)wb_getMessageDateStringFromTimeInterval:(NSTimeInterval)TimeInterval
                                          andNeedTime:(BOOL)needTime;

#pragma mark ------ < 系统相机相关 > ------
#pragma mark
- (UIImagePickerController *)wb_imagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType;

/**
 图库是否可用

 @return YES/NO
 */
- (BOOL)wb_isAvailablePhotoLibrary;

/**
 相机是否可用

 @return YES/NO
 */
- (BOOL)wb_isAvailableCamera;

/**
 是否支持拍照权限

 @return YES/NO
 */
- (BOOL)wb_isSupportTakingPhotos;

/**
 是否支持图库权限

 @return YES/NO
 */
- (BOOL)wb_isSupportPickPhotosFromPhotoLibrary;

/**
 是否支持媒体类型

 @param mediaType 媒体类型
 @param sourceType 媒体类型
 @return YES/NO
 */
- (BOOL)wb_isSupportsMedia:(NSString *)mediaType
                sourceType:(UIImagePickerControllerSourceType)sourceType;

#pragma mark ------ < 基础方法 > ------
#pragma mark
/**  < 拆分整数 >  */
- (NSArray *)getNumberArrayWithNumbers:(NSInteger)number;

#pragma mark ------ < 第一次启动程序 > ------
#pragma mark
- (BOOL)wb_isNeedGuide;

@end
