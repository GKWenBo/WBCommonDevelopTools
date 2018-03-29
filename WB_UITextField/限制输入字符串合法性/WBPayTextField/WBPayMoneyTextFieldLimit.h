//
//  WBPayMoneyTextFieldLimit.h
//  保证金额输入合法性
//
//  Created by WMB on 2017/9/24.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol WBPayMoneyTextFieldLimitDelegate <NSObject>

- (void)valueChange:(id)sender;

@end
@interface WBPayMoneyTextFieldLimit : NSObject <UITextFieldDelegate>

@property (nonatomic, strong) NSString *max; // 默认99999.99
@property (nonatomic,assign) id <WBPayMoneyTextFieldLimitDelegate> delegate;

- (void)valueChange:(id)sender;

@end
