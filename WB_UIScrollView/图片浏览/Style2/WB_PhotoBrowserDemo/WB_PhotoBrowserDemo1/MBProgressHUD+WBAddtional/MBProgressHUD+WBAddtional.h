//
//  MBProgressHUD+WB.h
//  MBProgressHUD+WB1
//
//  Created by WMB on 2017/6/11.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (WBAddtional)
#pragma mark --------  基础方法  --------
#pragma mark
/**
 *  快速创建提示框 有菊花
 *
 *  @param message 提示信息
 *  @param view 显示视图
 *  @return hud
 */
+ (MBProgressHUD *)wb_showActivityMessage:(NSString *)message
                                   toView:(UIView *)view;
/**
 *  显示提示文字
 *
 *  @param message 提示信息
 *  @param view 显示的视图
 */
+ (void)wb_showMessage:(NSString *)message
                toView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion;
/**
 *  自定义成功提示
 *
 *  @param success 提示文字
 *  @param view 显示视图
 */
+ (void)wb_showSuccess:(NSString *)success
                toView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion;
/**
 *  自定义失败提示
 *
 *  @param error 提示文字
 *  @param view 显示视图
 */
+ (void)wb_showError:(NSString *)error
              toView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion;
/**
 *  自定义提示信息
 *
 *  @param info 提示信息
 *  @param view 示视图
 */
+ (void)wb_showInfo:(NSString *)info
             toView:(UIView *)view
         completion:(MBProgressHUDCompletionBlock)completion;

/**
 *  自定义警告提示
 *
 *  @param warning 提示信息
 *  @param view 示视图
 */
+ (void)wb_showWarning:(NSString *)warning
                toView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion;

/**
 *  自定义提示框
 *
 *  @param text 提示文字
 *  @param icon 图片名称
 *  @param view 展示视图
 */
+ (void)wb_show:(NSString *)text
           icon:(NSString *)icon
           view:(UIView *)view
     completion:(MBProgressHUDCompletionBlock)completion;

#pragma mark --------  提示有菊花  --------
#pragma mark
+ (MBProgressHUD *)wb_showActivity;
+ (MBProgressHUD *)showActivityMessage:(NSString *)message;

#pragma mark --------  提示文字  --------
#pragma mark
+ (void)wb_showMessage:(NSString *)message completion:(MBProgressHUDCompletionBlock)completion;
+ (void)wb_showSuccess:(NSString *)success completion:(MBProgressHUDCompletionBlock)completion;
+ (void)wb_showError:(NSString *)error completion:(MBProgressHUDCompletionBlock)completion;
+ (void)wb_showInfo:(NSString *)info completion:(MBProgressHUDCompletionBlock)completion;
+ (void)wb_showWarning:(NSString *)warning completion:(MBProgressHUDCompletionBlock)completion;

#pragma mark --------  隐藏  --------
#pragma mark
+ (void)wb_hideHUD;
+ (void)wb_hideHUDForView:(UIView *)view;

@end
