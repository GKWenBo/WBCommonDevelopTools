//
//  WB_TopBarView.h
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WB_TopBarViewDelegate <NSObject>

/*
 * 代理方法，点击表情按钮触发方法
 */
- (void)TopBarEmotionBtnDidClicked:(UIButton *)emotionBtn;
/*
 * 代理方法 ，点击数字键盘发送的事件
 */
- (void)sendAction;
/*
 * 键盘改变刷新父视图
 */
- (void)needUpdateSuperView;

@end

@interface WBTopBarView : UIView

/*
 * topbar代理
 */
@property (nonatomic,assign) id <WB_TopBarViewDelegate> delegate;

/*
 * topbar上面的输入框
 */
@property(strong,nonatomic)UITextView *textView;
/*
 * 表情按钮
 */
@property(nonatomic, strong) UIButton *topBarEmotionBtn;
/**
 分享按钮
 */
@property (nonatomic,strong) UIButton * shareButton;
/*
 * 当前键盘的高度， 区分是文字键盘还是表情键盘
 */
@property(nonatomic, assign) CGFloat CurrentKeyBoardH;
/*
 * 用于主动触发输入框改变的方法
 */
- (void)resetSubsives;

@end
