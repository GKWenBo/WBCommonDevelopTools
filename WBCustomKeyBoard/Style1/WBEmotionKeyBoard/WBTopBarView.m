//
//  WB_TopBarView.m
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBTopBarView.h"
#import "WB_EmotionKeyBoardConfigHeader.h"

#define maxHeight 90

@interface WBTopBarView () <UITextViewDelegate>

@property(nonatomic, strong) UIView *topLine;
@property(nonatomic, strong) UIView *bottomLine;
@end

@implementation WBTopBarView

#pragma mark -- 初始化
#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self userMethod];
    }
    return self;
}

#pragma mark -- 创建子视图
#pragma mark
- (void)userMethod {
    //config subviews
    [self initSomething];
    [self addSubviews];
    [self layoutViews];
}

//初始化数据设置
- (void)initSomething {
    self.userInteractionEnabled = YES;
    self.backgroundColor = kWB_RGB_COLOR(236, 237, 241);
    self.CurrentKeyBoardH = keyBoardH;
}

//添加子视图
- (void)addSubviews {
    [self addSubview:self.textView];
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    [self addSubview:self.topBarEmotionBtn];
    [self addSubview:self.shareButton];
}

//约束位置
- (void)layoutViews {
    self.frame = CGRectMake(0, SCREEN_HEIGHT - topBarH - kNAVIBAR_HEIGHT , SCREEN_WIDTH, CGRectGetMaxY(self.textView.frame) + 5);
    self.bottomLine.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, SCREEN_WIDTH, 0.5);
    self.topLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    self.topBarEmotionBtn.frame = CGRectMake(CGRectGetMaxX(_textView.frame) + 10, CGRectGetHeight(self.frame) - 5 - emotionBtnH, emotionBtnW, emotionBtnH);
    self.shareButton.frame = CGRectMake(SCREEN_WIDTH - emotionW - 10, CGRectGetHeight(self.frame) - 5 - emotionBtnH, emotionBtnW, emotionBtnH);
}

//更新子视图
- (void)updateSubviews {
    CGFloat differenceH = self.textView.wb_height - TextViewH;
    self.frame = CGRectMake(0, SCREEN_HEIGHT - self.CurrentKeyBoardH - topBarH - differenceH - 64, SCREEN_WIDTH, CGRectGetMaxY(self.textView.frame) + 5);
    self.bottomLine.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, SCREEN_WIDTH, 0.5);
    self.topLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    self.topBarEmotionBtn.frame = CGRectMake(CGRectGetMaxX(_textView.frame) + 10, CGRectGetHeight(self.frame) - 5 - emotionBtnH, emotionBtnW, emotionBtnH);
    self.shareButton.frame = CGRectMake(SCREEN_WIDTH - emotionW - 10, CGRectGetHeight(self.frame) - 5 - emotionBtnH, emotionBtnW, emotionBtnH);
    if ([self.delegate respondsToSelector:@selector(needUpdateSuperView)]) {
        [self.delegate needUpdateSuperView];
    }
}

#pragma mark --------  事件  --------
#pragma mark
//键盘切换按钮事件
- (void)emotionBtnDidClicked:(UIButton *)emotionBtn {
    if ([self.delegate respondsToSelector:@selector(TopBarEmotionBtnDidClicked:)]) {
        [self.delegate TopBarEmotionBtnDidClicked:emotionBtn];
    }
}
//共有方法，用于主动触发键盘改变的方法
- (void)resetSubsives {
    [self textViewDidChange:self.textView];
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //[self configUI];
    
}

#pragma mark -- 绘图
#pragma mark
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
#pragma mark --------  Private Method  --------
#pragma mark
- (NSAttributedString *)attributedPlaceholder {
    /**  < // 添加表情 >  */
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    /**  < 表情图片 >  */
    attch.image = kWB_IMAGEWITHNAME(@"写");
    attch.bounds = CGRectMake(0, 0, 18, 18);
    /**  < 创建带有图片的富文本 >  */
    NSString *placeholder = @" 写评论...";
    NSAttributedString *attributedStr = [NSAttributedString attributedStringWithAttachment:attch];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:placeholder];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSRangeFromString(placeholder)];
    [text addAttribute:NSFontAttributeName value:kWB_PFR_FONT14 range:NSRangeFromString(placeholder)];
    [text insertAttributedString:attributedStr atIndex:0];
    return text;
}


#pragma mark --------  UITextViewDelegate  --------
#pragma mark
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        if ([self.delegate respondsToSelector:@selector(sendAction)]) {
            [self.delegate sendAction];
        }
        return NO;
    }
    return YES;
}

//监听键盘改变，重设控件frame
- (void)textViewDidChange:(UITextView *)textView {
    CGFloat width   = CGRectGetWidth(textView.frame);
    CGSize newSize  = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    CGRect newFrame = textView.frame;
    CGRect maxFrame = textView.frame;
    maxFrame.size   = CGSizeMake(width, maxHeight);
    newFrame.size   = CGSizeMake(width, newSize.height);
    [UIView animateWithDuration:0.25 animations:^{
        if (newSize.height <= maxHeight) {
            
            textView.frame  = newFrame;
            textView.scrollEnabled = NO;
        }else {
            
            textView.frame = maxFrame;
            textView.scrollEnabled = YES;
        }
        [self updateSubviews];
    }];
}


#pragma mark -- Getter and Setter
#pragma mark
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.returnKeyType = UIReturnKeySend;
        _textView.layer.cornerRadius = 5;
        _textView.layer.borderWidth = 0.5f;
        _textView.layer.borderColor = kWB_RGB_COLOR(215, 215, 225).CGColor;
        _textView.scrollEnabled = YES;
        _textView.frame = CGRectMake(10, 5, TextViewW, TextViewH);
        _textView.delegate = self;
        _textView.font = kWB_PFR_FONT15;
        _textView.placeholderLabel.textAlignment = NSTextAlignmentRight;
        _textView.attributedPlaceholder = [self attributedPlaceholder];
        [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
    }
    return _textView;
}

- (UIView *)bottomLine {
    
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = kWB_RGB_COLOR(215, 215, 225);
    }
    return _bottomLine;
}

- (UIView *)topLine {
    
    if (!_topLine) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = kWB_RGB_COLOR(215, 215, 225);
    }
    return _topLine;
}

- (UIButton *)topBarEmotionBtn {
    
    if (!_topBarEmotionBtn) {
        _topBarEmotionBtn = [[UIButton alloc]init];
        [_topBarEmotionBtn setImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
        [_topBarEmotionBtn setImage:[UIImage imageNamed:@"表情"] forState:UIControlStateSelected];
        [_topBarEmotionBtn addTarget:self action:@selector(emotionBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topBarEmotionBtn;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [[UIButton alloc]init];
        [_shareButton setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateSelected];
        [_shareButton addTarget:self action:@selector(emotionBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

@end
