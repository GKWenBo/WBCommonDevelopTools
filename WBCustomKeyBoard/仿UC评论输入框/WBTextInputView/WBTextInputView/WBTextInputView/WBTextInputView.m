//
//  WBTextInputView.m
//  WBTextInputView
//
//  Created by Admin on 2017/11/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBTextInputView.h"

static CGFloat const kContentViewHeight = 120.f;
static CGFloat const kTextViewHeight = 60.f;
static CGFloat const kButtonSize = 44.f;
static CGFloat const kMargin = 5.f;

@interface WBTextInputView () <UIGestureRecognizerDelegate>

@end

@implementation WBTextInputView

- (void)dealloc {
    [self removeKeyboardNoti];
}
#pragma mark ------ < 初始化 > ------
#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark ------ < 设置UI > ------
#pragma mark
- (void)setupUI {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25f];
    self.alpha = 0.f;
    self.frame = [UIScreen mainScreen].bounds;
    [self addKeyboardNoti];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.blurImageView];
    [self.blurImageView addSubview:self.effectView];
    [self.effectView.contentView addSubview:self.cancelButton];
    [self.effectView.contentView addSubview:self.publishButton];
    [self.effectView.contentView addSubview:self.inputTextView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wb_hideKeyBoard)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

#pragma mark ------ < Private Method > ------
#pragma mark
- (void)addKeyboardNoti {
    [self removeKeyboardNoti];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)removeKeyboardNoti {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)wb_showKeyBoard {
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    if (!self.inputTextView.isFirstResponder) {
        [self.inputTextView becomeFirstResponder];
    }
}

- (void)wb_hideKeyBoard {
    [self.inputTextView resignFirstResponder];
}

#pragma mark ------ < Keyboard Notification > ------
#pragma mark
- (void)keyboardWillShow:(NSNotification *)noti {
    NSDictionary* info = [noti userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         self.alpha = 1.f;
                         self.contentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kContentViewHeight - kbSize.height, [UIScreen mainScreen].bounds.size.width, kContentViewHeight);
                     }
                     completion:nil];
}

//- (void)keyboardDidShow:(NSNotification *)noti {
//
//}

- (void)keyboardWillHide:(NSNotification *)noti {
    NSDictionary* info = [noti userInfo];
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         self.alpha = 0.f;
                         self.contentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, kContentViewHeight);
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

//- (void)keyboardDidHide:(NSNotification *)noti {
//}

#pragma mark ------ < Event Response > ------
#pragma mark
- (void)cancelButtonClicked {
    [self wb_hideKeyBoard];
}

- (void)publishButtonClicked {
    if (self.inputTextView.text.length == 0) {
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(WBTextInputView:clickedPublishButton:  )]) {
        [_delegate WBTextInputView:self clickedPublishButton:self.inputTextView.text];
    }
    
    [self wb_hideKeyBoard];
}

#pragma mark ------ < UIGestureRecognizerDelegate > ------
#pragma mark

#pragma mark ------ < Getter > ------
#pragma mark
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, kContentViewHeight)];
    }
    return _contentView;
}

- (UIImageView *)blurImageView {
    if (!_blurImageView) {
        _blurImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds))];
        _blurImageView.userInteractionEnabled = YES;
    }
    return _blurImageView;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
        _effectView.frame = self.blurImageView.bounds;
    }
    return _effectView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _cancelButton.frame = CGRectMake(kMargin, 0, kButtonSize, kButtonSize);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _publishButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - kMargin - kButtonSize, 0, kButtonSize, kButtonSize);
        [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
        [_publishButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_publishButton addTarget:self action:@selector(publishButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishButton;
}

- (UITextView *)inputTextView {
    if (!_inputTextView) {
        _inputTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.cancelButton.frame) + kMargin, [UIScreen mainScreen].bounds.size.width - 2 * 10, kTextViewHeight)];
        _inputTextView.layer.cornerRadius = 10.f;
        _inputTextView.layer.masksToBounds = YES;
        _inputTextView.backgroundColor = [UIColor lightGrayColor];
        _inputTextView.font = [UIFont systemFontOfSize:15.f];
    }
    return _inputTextView;
}

@end
