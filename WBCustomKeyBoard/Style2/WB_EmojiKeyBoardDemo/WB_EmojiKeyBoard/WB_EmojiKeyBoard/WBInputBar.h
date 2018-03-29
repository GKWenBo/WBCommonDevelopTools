//
//  WB_InputBar.h
//  WB_EmojiKeyBoard
//
//  Created by WMB on 2017/9/17.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBInputBar : UIView

+ (instancetype)inputBar;
@property (assign, nonatomic) BOOL fitWhenKeyboardShowOrHide;
- (void)setDidSendClicked:(void(^)(NSString *text))handler;
@property (copy, nonatomic) NSString *placeHolder;

@end
