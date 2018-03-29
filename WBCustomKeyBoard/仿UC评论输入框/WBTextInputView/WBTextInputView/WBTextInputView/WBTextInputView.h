//
//  WBTextInputView.h
//  WBTextInputView
//
//  Created by Admin on 2017/11/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTextInputView;

@protocol WBTextInputViewDelegate <NSObject>

@required

/**
 点击发布按钮

 @param textInputView textInputView description
 @param text 输入框文字
 */
- (void)WBTextInputView:(WBTextInputView *)textInputView clickedPublishButton:(NSString *)text;
@optional
- (void)wb_keyboardWillShow;
- (void)wb_keyboardWillHide;

@end

@interface WBTextInputView : UIView

/**  < 文字输入框 >  */
@property (nonatomic, strong) UITextView *inputTextView;
/**  < 发布按钮 >  */
@property (nonatomic, strong) UIButton *publishButton;
/**  < 取消按钮 >  */
@property (nonatomic, strong) UIButton *cancelButton;
/**  < 容器视图 >  */
@property (nonatomic, strong) UIView *contentView;
/**  < 文本输入框 圆角大小 >  */
@property (nonatomic, assign) CGFloat cornerRadius;
/**  < 背景视图 >  */
@property (nonatomic, strong) UIImageView *blurImageView;
/**  < 毛玻璃效果 >  */
@property (nonatomic, strong) UIVisualEffectView *effectView;
/**  < 占位符 >  */
@property (nonatomic,strong) NSString *placeholder;
/**  < 代理 >  */
@property (nonatomic, assign) id<WBTextInputViewDelegate> delegate;

- (void)wb_showKeyBoard;
- (void)wb_hideKeyBoard;

@end
