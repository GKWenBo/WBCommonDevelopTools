//
//  WB_InputBar.m
//  WB_EmojiKeyBoard
//
//  Created by WMB on 2017/9/17.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBInputBar.h"
#import "WBEmojiKeyBoard.h"

#define kWB_IBDefaultHeight 44
#define kWB_LeftButtonWidth 50
#define kWB_LeftButtonHeight 30
#define kWB_RightButtonWidth 55
#define kWB_TextviewDefaultHeight 34
#define kWB_TextviewMaxHeight 80

@interface WBInputBar () <UITextViewDelegate>

@property (strong, nonatomic) UIButton *keyboardTypeButton;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *sendButton;
@property (strong, nonatomic) WBEmojiKeyBoard *keyboard;
@property (strong, nonatomic) UILabel *placeHolderLabel;

@property (strong, nonatomic) void (^sendDidClickedHandler)(NSString *);

@end

@implementation WBInputBar {
    BOOL _isRegistedKeyboardNotif;
    BOOL _isDefaultKeyboard;
    NSArray *_switchKeyboardImages;
}

+ (instancetype)inputBar{
    return [self new];
}

- (void)dealloc{
    if (_isRegistedKeyboardNotif){
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kWB_IBDefaultHeight)]){
        _isRegistedKeyboardNotif = NO;
        _isDefaultKeyboard = YES;
        _switchKeyboardImages = @[@"btn_expression",@"btn_keyboard"];
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    
    _keyboard = [WBEmojiKeyBoard keyboard];
    
    self.keyboardTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, (kWB_IBDefaultHeight-kWB_LeftButtonHeight)/2, kWB_LeftButtonWidth, kWB_LeftButtonHeight)];
    [_keyboardTypeButton addTarget:self action:@selector(keyboardTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _keyboardTypeButton.tag = 0;
    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[_keyboardTypeButton.tag]] forState:UIControlStateNormal];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(kWB_LeftButtonWidth, (kWB_IBDefaultHeight-kWB_TextviewDefaultHeight)/2, CGRectGetWidth(self.frame)-kWB_LeftButtonWidth-kWB_RightButtonWidth, kWB_TextviewDefaultHeight)];
    self.textView.backgroundColor = [UIColor clearColor];
    //    self.textView.textContainerInset = UIEdgeInsetsMake(5.0f, 0.0f, 5.0f, 0.0f);
    self.textView.textColor = [UIColor whiteColor];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.delegate = self;
    self.textView.tintColor = [UIColor whiteColor];
    self.textView.scrollEnabled = NO;
    self.textView.showsVerticalScrollIndicator = NO;
    
    _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWB_LeftButtonWidth+5, CGRectGetMinY(_textView.frame), CGRectGetWidth(_textView.frame), kWB_TextviewDefaultHeight)];
    _placeHolderLabel.adjustsFontSizeToFitWidth = YES;
    _placeHolderLabel.minimumScaleFactor = 0.9;
    _placeHolderLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    _placeHolderLabel.font = _textView.font;
    _placeHolderLabel.userInteractionEnabled = NO;
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sendButton.frame = CGRectMake(self.frame.size.width-kWB_RightButtonWidth, 0, kWB_RightButtonWidth, kWB_IBDefaultHeight);
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.3] forState:UIControlStateDisabled];
    [self.sendButton setTitleEdgeInsets:UIEdgeInsetsMake(2.50f, 0.0f, 0.0f, 0.0f)];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.sendButton addTarget:self action:@selector(sendTextCommentTaped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendButton.enabled = NO;
    
    [self addSubview:_keyboardTypeButton];
    [self addSubview:_textView];
    [self addSubview:_placeHolderLabel];
    [self addSubview:self.sendButton];
}

- (void)layout{
    self.sendButton.enabled = ![@"" isEqualToString:self.textView.text];
    _placeHolderLabel.hidden = self.sendButton.enabled;
    
    CGRect textViewFrame = self.textView.frame;
    CGSize textSize = [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 1000.0f)];
    CGFloat offset = 10;
    self.textView.scrollEnabled = (textSize.height > kWB_TextviewMaxHeight-offset);
    textViewFrame.size.height = MAX(kWB_TextviewDefaultHeight, MIN(kWB_TextviewMaxHeight, textSize.height));
    self.textView.frame = textViewFrame;
    
    CGRect addBarFrame = self.frame;
    CGFloat maxY = CGRectGetMaxY(addBarFrame);
    addBarFrame.size.height = textViewFrame.size.height+offset;
    addBarFrame.origin.y = maxY-addBarFrame.size.height;
    self.frame = addBarFrame;
    
    self.keyboardTypeButton.center = CGPointMake(CGRectGetMidX(self.keyboardTypeButton.frame), CGRectGetHeight(addBarFrame)/2.0f);
    self.sendButton.center = CGPointMake(CGRectGetMidX(self.sendButton.frame), CGRectGetHeight(addBarFrame)/2.0f);
}

#pragma mark --------  Public  --------
#pragma mark
- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolderLabel.text = placeHolder;
    _placeHolder = [placeHolder copy];
}

- (BOOL)resignFirstResponder{
    [super resignFirstResponder];
    return [_textView resignFirstResponder];
}

- (void)registerKeyboardNotif{
    _isRegistedKeyboardNotif = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setDidSendClicked:(void (^)(NSString *))handler{
    _sendDidClickedHandler = handler;
}

- (void)setFitWhenKeyboardShowOrHide:(BOOL)fitWhenKeyboardShowOrHide{
    if (fitWhenKeyboardShowOrHide){
        [self registerKeyboardNotif];
    }
    if (!fitWhenKeyboardShowOrHide && _fitWhenKeyboardShowOrHide){
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    _fitWhenKeyboardShowOrHide = fitWhenKeyboardShowOrHide;
}

#pragma mark --------  通知  --------
#pragma mark
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         CGRect newInputBarFrame = self.frame;
                         newInputBarFrame.origin.y = [UIScreen mainScreen].bounds.size.height-CGRectGetHeight(self.frame)-kbSize.height;
                         self.frame = newInputBarFrame;
                     }
                     completion:nil];
}

- (void)keyboardWillHidden:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         self.center = CGPointMake(self.bounds.size.width/2.0f, height-CGRectGetHeight(self.frame)/2.0);
                     }
                     completion:nil];
}

#pragma mark --------  Action  --------
#pragma mark
- (void)sendTextCommentTaped:(UIButton *)button{
    if (self.sendDidClickedHandler){
        self.sendDidClickedHandler(self.textView.text);
        self.textView.text = @"";
        [self layout];
    }
}

- (void)keyboardTypeButtonClicked:(UIButton *)button{
    if (button.tag == 1){
        self.textView.inputView = nil;
    }
    else{
        [_keyboard setTextView:self.textView];
    }
    [self.textView reloadInputViews];
    button.tag = (button.tag+1)%2;
    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[button.tag]] forState:UIControlStateNormal];
    [_textView becomeFirstResponder];
}

#pragma mark --------  UITextViewDelegate  --------
#pragma mark
- (void)textViewDidChange:(UITextView *)textView{
    self.sendButton.enabled = ![@"" isEqualToString:textView.text];
    [self layout];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}

@end
