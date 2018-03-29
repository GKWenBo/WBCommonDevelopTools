//
//  WB_AlertManager.h
//  WB_AlertManager
//
//  Created by WMB on 2017/5/16.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AlertAcion)();

#define kWBALERTMANAGER [WBAlertManager shareManager]

@interface WBAlertManager : NSObject

/**  管理类  */
+ (instancetype)shareManager;

/**
 @brief  模式对话框，选择一项（UIAlertView与与UIAlertController封装，根据不同ios版本对应选择调用方法）
 @param title        标题
 @param message          提示内容
 @param block        返回点击的按钮index,按照buttonsStatement按钮的顺序，从0开始
 @param cancelString 取消按钮 文本，必须以nil结束
 */
- (void)wb_showAlertWithTitle:(NSString*)title
                      message:(NSString*)message
                  chooseBlock:(void (^)(NSInteger clickedIdx))block
             buttonsStatement:(NSString*)cancelString, ...;

/**
 @brief  显示UIActionSheet模式对话框，UIActionSheet与UIAlertController封装，根据不同ios版本对应选择调用方法。
 @param title                  标题
 @param message                消息内容,大于ios8.0才会显示
 @param block                  返回block,buttonIdx:cancelString,destructiveButtonTitle分别为0、1,
 otherButtonTitle从后面开始，如果destructiveButtonTitle没有，buttonIndex1开始，反之2开始
 @param cancelString           取消文本
 @param destructiveButtonTitle 特殊标记按钮，默认红色文字显示
 @param otherButtonTitle       其他选项,必须以nil结束
 */
- (void)wb_showActionSheetWithTitle:(NSString*)title
                            message:(NSString *)message chooseBlock:(void (^)(NSInteger clickedIdx))block
                  cancelButtonTitle:(NSString*)cancelString
             destructiveButtonTitle:(NSString*)destructiveButtonTitle
                   otherButtonTitle:(NSString*)otherButtonTitle,...;

/**
 * 弹出中间一个按钮提示框
 *
 *  @param title 标题
 *  @param message 详细信息
 *  @param actionTitle 按钮标题
 */
- (void)wb_showOneAlertAcionWithTitle:(NSString *)title
                              message:(NSString *)message
                          actionTitle:(NSString *)actionTitle
                          actionBlock:(AlertAcion)actionBlock;

#pragma mark -- 提示框自动消失
#pragma mark
/**
 *  中间提示框，几秒后自动消失
 *
 *  @param title 标题
 *  @param message 提示文字
 *  @param dismissAfterDelay 延迟消失时间
 */
- (void)wb_showAutoDismissAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                  dismissAfterDelay:(CGFloat)dismissAfterDelay;
/**
 *  中间提示框，2秒后自动消失
 *
 *  @param title 标题
 *  @param message 提示文字
 */
- (void)wb_showAutoDismissAlertWithTitle:(NSString *)title
                            message:(NSString *)message;

/**
 *  底部提示框 自动消失
 *
 *  @param title 标题
 *  @param message 提示文字
 *  @param dismissAfterDelay 延迟消失时间
 */
- (void)wb_showAutoDismissAcionSheetWithTitle:(NSString *)title
                                      message:(NSString *)message
                            dismissAfterDelay:(CGFloat)dismissAfterDelay;
/**
 *  底部提示框 2秒自动消失
 *
 *  @param title 标题
 *  @param message 提示文字
 */
- (void)wb_showAutoDismissAcionSheetWithTitle:(NSString *)title
                                      message:(NSString *)message;
#pragma mark -- 中间两个按钮
#pragma mark
/**
 *  中间弹出两个按钮
 *
 *  @param title 标题
 *  @param message 提示信息
 *  @param cancleTitle 左边按钮标题
 *  @param confirmTitle 右边按钮标题
 *  @param cancelAcion 左边按钮点击回调
 *  @param confirmAction 右边按钮点击回调
 */
- (void)wb_showTwoAlertActionWithTitle:(NSString *)title
                               message:(NSString *)message
                           cancleTitle:(NSString *)cancleTitle
                          confirmTitle:(NSString *)confirmTitle
                           cancelAcion:(AlertAcion)cancelAcion
                         confirmAction:(AlertAcion)confirmAction;
/**
 *  中间弹出两个按钮(左边取消，右边确定)
 *
 *  @param title 标题
 *  @param message 提示文字
 *  @param confirmAction 右边按钮点击回调

 */
- (void)wb_showTwoAlertActionWithTitle:(NSString *)title
                               message:(NSString *)message
                         confirmAction:(AlertAcion)confirmAction;

@end
