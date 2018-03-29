//
//  WB_AlertManager.m
//  WB_AlertManager
//
//  Created by WMB on 2017/5/16.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBAlertManager.h"

static WBAlertManager * manager = nil;
@implementation WBAlertManager

+ (instancetype)shareManager {
    if (!manager) {
        manager = [[self alloc]init];
    }
    return manager;
}

- (void)wb_showAlertWithTitle:(NSString *)title message:(NSString *)message chooseBlock:(void (^)(NSInteger))block buttonsStatement:(NSString *)cancelString, ... {
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:2];
    [argsArray addObject:cancelString];
    id arg;
    va_list argList;
    if(cancelString)
    {
        va_start(argList,cancelString);
        while ((arg = va_arg(argList,id)))
        {
            [argsArray addObject:arg];
        }
        va_end(argList);
    }
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)) {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (int i = 0; i < [argsArray count]; i++)
        {
            UIAlertActionStyle style =  (0 == i)? UIAlertActionStyleCancel: UIAlertActionStyleDefault;
            // Create the actions.
            UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction *action) {
                if (block) {
                    block(i);
                }
            }];
            [alertController addAction:action];
        }
        [[self getTopViewController] presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
}

- (void)wb_showActionSheetWithTitle:(NSString *)title message:(NSString *)message chooseBlock:(void (^)(NSInteger))block cancelButtonTitle:(NSString *)cancelString destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitle:(NSString *)otherButtonTitle, ... {
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:3];
    if (cancelString) {
        [argsArray addObject:cancelString];
    }
    if (destructiveButtonTitle) {
        [argsArray addObject:destructiveButtonTitle];
    }
    id arg;
    va_list argList;
    if(otherButtonTitle)
    {
        [argsArray addObject:otherButtonTitle];
        va_start(argList,otherButtonTitle);
        while ((arg = va_arg(argList,id)))
        {
            [argsArray addObject:arg];
        }
        va_end(argList);
    }

    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)) {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        for (int i = 0; i < [argsArray count]; i++)
        {
            UIAlertActionStyle style =  (0 == i)? UIAlertActionStyleCancel: UIAlertActionStyleDefault;
            
            if (1==i && destructiveButtonTitle) {
                
                style = UIAlertActionStyleDestructive;
            }
            // Create the actions.
            UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction *action) {
                if (block) {
                    block(i);
                }
            }];
            [alertController addAction:action];
        }
        
        [[self getTopViewController] presentViewController:alertController animated:YES completion:nil];
        return;
    }
}

- (void)wb_showOneAlertAcionWithTitle:(NSString *)title
                              message:(NSString *)message
                          actionTitle:(NSString *)actionTitle
                          actionBlock:(AlertAcion)actionBlock {
    
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * acion = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (actionBlock) {
            actionBlock();
        }
    }];
    
    [alertVc addAction:acion];
    
    [[self getTopViewController] presentViewController:alertVc animated:YES completion:nil];
}

- (void)wb_showAutoDismissAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                  dismissAfterDelay:(CGFloat)dismissAfterDelay {
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [[self getTopViewController] presentViewController:alertVc animated:YES completion:^{
        
        [self performSelector:@selector(dismiss:) withObject:alertVc afterDelay:dismissAfterDelay];
    }];
}

- (void)wb_showAutoDismissAlertWithTitle:(NSString *)title
                            message:(NSString *)message {
    [self wb_showAutoDismissAlertWithTitle:title message:message dismissAfterDelay:2.f];
}
- (void)wb_showAutoDismissAcionSheetWithTitle:(NSString *)title
                                              message:(NSString *)message
                                    dismissAfterDelay:(CGFloat)dismissAfterDelay {
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    [[self getTopViewController] presentViewController:alertVc animated:YES completion:^{
        [self performSelector:@selector(dismiss:) withObject:alertVc afterDelay:dismissAfterDelay];
    }];
}
- (void)wb_showAutoDismissAcionSheetWithTitle:(NSString *)title
                                      message:(NSString *)message {
    [self wb_showAutoDismissAcionSheetWithTitle:title message:message dismissAfterDelay:2.f];
}
- (void)wb_showTwoAlertActionWithTitle:(NSString *)title
                               message:(NSString *)message
                           cancleTitle:(NSString *)cancleTitle
                          confirmTitle:(NSString *)confirmTitle
                           cancelAcion:(AlertAcion)cancelAcion
                         confirmAction:(AlertAcion)confirmAction {
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * acion1 = [UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelAcion) {
            cancelAcion();
        }
    }];
    UIAlertAction * acion2 = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirmAction) {
            confirmAction();
        }
    }];
    [alertVc addAction:acion1];
    [alertVc addAction:acion2];
    [[self getTopViewController] presentViewController:alertVc animated:YES completion:^{
        
    }];
}
- (void)wb_showTwoAlertActionWithTitle:(NSString *)title
                               message:(NSString *)message
                         confirmAction:(AlertAcion)confirmAction; {
    [self wb_showTwoAlertActionWithTitle:title message:message cancleTitle:@"取消" confirmTitle:@"确定" cancelAcion:^{
        
    } confirmAction:^{
        if (confirmAction) {
            confirmAction();
        }
    }];
}
#pragma mark -- Private Method
#pragma mark
- (UIViewController*)getTopViewController
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
- (void)dismiss:(UIAlertController *)alertVc {
    [alertVc dismissViewControllerAnimated:YES completion:nil];
}

@end
