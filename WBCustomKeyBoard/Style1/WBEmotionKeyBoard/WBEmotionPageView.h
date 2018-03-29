//
//  WB_EmotionPageView.h
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBEmotionButton.h"
@interface WBEmotionPageView : UIView
/*
 * 当前page的页数
 */
@property(nonatomic, assign) NSUInteger page;
/*
 * 表情按钮的回调事件
 * 参数button是当前点击按钮的对象
 */
@property(nonatomic, copy)void (^emotionButtonClick)(WBEmotionButton *button);
/*
 * 键盘上删除按钮的回调事件
 * 参数button是当前点击的删除按钮
 */
@property(nonatomic, copy)void (^deleteButtonClick)(WBEmotionButton *button);
@end
