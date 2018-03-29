//
//  WBEmotionKeyBoard.h
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBTopBarView.h"

@protocol WB_EmotionKeyBoardDelegate <NSObject>

/*
 * 发送按钮的代理事件
 * 参数PlainStr: 转码后的textView的普通字符串
 */
- (void)sendButtonEventsWithPlainString:(NSString *)PlainStr;
/*
 * 代理方法：键盘改变的代理事件
 * 用来更新父视图的UI，比如跟随键盘改变的列表高度
 */
- (void)keyBoardChanged;

@end

@interface WBEmotionKeyBoard : UIView
/*
 * 输入框，和topbar上的是同一个输入框
 */
@property(nonatomic, strong) UITextView *textView;
/*
 * 顶部输入条
 */
@property(nonatomic, strong) WBTopBarView *topBar;
/*
 * 输入框字体，用来计算表情的大小
 */
@property(nonatomic, strong) UIFont *font;
/*
 * 键盘的代理
 */
@property(nonatomic, weak) id <WB_EmotionKeyBoardDelegate> delegate;
/*
 * 收起键盘的方法
 */
- (void)hideKeyBoard;
/*
 * 初始化方法
 * 参数view必须传入控制器的视图
 * 会返回一个键盘的对象
 * 默认是给17号字体
 */
+ (instancetype)showKeyBoardInView:(UIView *)view;

@end
