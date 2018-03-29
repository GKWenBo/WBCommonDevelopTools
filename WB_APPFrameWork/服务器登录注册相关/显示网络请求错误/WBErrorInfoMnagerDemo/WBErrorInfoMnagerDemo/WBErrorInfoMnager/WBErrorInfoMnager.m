//
//  WBErrorInfoMnager.m
//  WBErrorInfoMnagerDemo
//
//  Created by WMB on 2017/9/25.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBErrorInfoMnager.h"

@implementation WBErrorInfoMnager
+ (void)wb_checkAndShowError:(NSError *)error {
//    if (error.userInfo[kServiceResponseStatusMsgKey]) {
//        if (error.userInfo[kServiceResponseStatusMsgKey] != nil) {
//            //            [SVProgressHUD showErrorWithStatus:error.userInfo[kServiceResponseStatusMsgKey]];
//            [MBProgressHUD wb_showError:error.userInfo[kServiceResponseStatusMsgKey] completion:^{
//            }];
//            
//        } else {
//            //            [SVProgressHUD showErrorWithStatus:@"系统错误"]
//            [MBProgressHUD wb_showError:@"系统错误" completion:^{
//            }];
//        }
//    } else {
//        //        [SVProgressHUD showErrorWithStatus:@"系统错误"];
//        [MBProgressHUD wb_showError:@"系统错误" completion:^{
//        }];
//    }
    NSLog(@"error --- %@",error);
}
@end
