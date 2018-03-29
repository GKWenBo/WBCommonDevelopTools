//
//  WB_PayTextField.h
//  保证金额输入合法性
//
//  Created by WMB on 2017/5/15.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WBPayMoneyTextFieldLimit.h"

@interface WBPayTextField : UITextField

- (WBPayMoneyTextFieldLimit *)limit;

@end
