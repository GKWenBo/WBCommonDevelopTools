//
//  WBPopBottomBar.h
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBPublishPopBottomBar : UIView

@property (nonatomic, strong) UIButton *closeButton;

//恢复按钮位置
- (void)btnResetPosition;

+ (CGFloat)bottomViewHeight;

@end
