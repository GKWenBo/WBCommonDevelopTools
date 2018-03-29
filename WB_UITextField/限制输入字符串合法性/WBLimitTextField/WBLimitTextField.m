//
//  WB_LimitTextField.m
//  保证金额输入合法性
//
//  Created by WMB on 2017/5/15.
//  Copyright © 2017年 文波. All rights reserved.
//

/*
 主要方法：
 法1> 主要用来判断可以不可以输入
 法2> 处理超过规定后，截取想要的范围！
 
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
 
 -(void)setupLimits:(NSString *)toBeString;
 
 */

#import "WBLimitTextField.h"

#define kNumbersPeriod  @"0123456789."

@implementation WBLimitTextField

#pragma mark -- 初始化
#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self configUI];
    }
    return self;
}

#pragma mark -- 创建子视图
#pragma mark
- (void)configUI {
    //config subviews
    self.delegate = (id <UITextFieldDelegate>)self;
    /**  不自动提示  */
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self wb_addTargetEditingChanged];
    
    /**  默认不能以.开头  */
    _isPriceHeaderPoint = NO;
}

- (void)setIsOnlyNumber:(BOOL)isOnlyNumber {
    _isOnlyNumber = isOnlyNumber;
    if (_isOnlyNumber) {
        _isPrice = NO;
    }
    self.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)setMaxNumberCount:(NSInteger)maxNumberCount {
    _isOnlyNumber = YES;
    _maxNumberCount = maxNumberCount;
    self.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)setIsPrice:(BOOL)isPrice {
    _isPrice = isPrice;
    /**  防止冲突  */
    if (_isPrice) {
        _isOnlyNumber = NO;
    }
    self.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)setIsPriceHeaderPoint:(BOOL)isPriceHeaderPoint {
    _isPriceHeaderPoint = isPriceHeaderPoint;
    _isPrice = YES;
    self.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)setMaxCharactersLength:(NSInteger)maxCharactersLength {
    _maxCharactersLength = maxCharactersLength;
    /**  防止冲突（也仅仅是最大字符串的中英限制）  */
    if (_maxCharactersLength > 0) {
        _maxTextLength = 0;
    }
}

- (void)setMaxTextLength:(NSInteger)maxTextLength
{
    _maxTextLength = maxTextLength;
    if (_maxTextLength > 0) {
        _maxCharactersLength = 0;
    }
}

#pragma mark -- UITextfieldDelegate
#pragma mark
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //  判断输入的是否为数字 (只能输入数字)
    if (_isOnlyNumber) {
        return [WB_TFTool isNumber:string];
    }
    //价格
    if (_isPrice) {
        //开头处理
        if (!_isPriceHeaderPoint) {
            if (textField.text.length == 0) {
                if ([string isEqualToString:@"."]) {
                    textField.text = @"0.";
                }
            }
        }
        return [self limitTwoAfterPoint:string textField:textField range:range];
    }
    
    return YES;
}


#pragma mark -- 小数点后限制两位
#pragma mark
- (BOOL)limitTwoAfterPoint:(NSString *)string textField:(UITextField *)textField range:(NSRange)range
{
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kNumbersPeriod] invertedSet];
    NSString *filtered =
    [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [string isEqualToString:filtered];
    if (basic) {
        NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
        [futureString  insertString:string atIndex:range.location];
        
        NSInteger flag=0;
        
        const NSInteger limited = 2;//小数点后需要限制的个数
        
        for (int i = (int)futureString.length-1; i>=0; i--) {
            if ([futureString characterAtIndex:i] == '.') {
                
                if (flag > limited) {
                    return NO;
                }
                break;
            }
            flag++;
        }
        
        return YES;
    }else{
        return NO;
    }
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self configUI];
    
}


#pragma mark -- Event Response
#pragma mark
- (void)wb_addTargetEditingChanged
{
    [self addTarget:self action:@selector(textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldTextLengthLimit:(id)sender
{
    
    //价格限制一个“.”，微信和支付宝转账都可以“.”开头
    if (_isPrice) {
        [WB_TFTool limitedPointOnlyOne:self];
    }
    
    bool isChinese;//判断当前输入法是否是中文
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    //[[UITextInputMode currentInputMode] primaryLanguage]，废弃的方法
    if ([current.primaryLanguage isEqualToString: @"en-US"]) {
        isChinese = false;
    }
    else
    {
        isChinese = true;
    }
    
    if(sender == self) {
        NSString *toBeString = self.text;
        if (isChinese) { //中文输入法下
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                [self setupLimits:toBeString];
            }
        }else{
            [self setupLimits:toBeString];
        }
    }
}

- (void)setupLimits:(NSString *)toBeString
{
    //纯数字限制：如果限制最大个数大于0，就配置_maxNumberCount，不允许多输入
    if (_isOnlyNumber) {
        if ([WB_TFTool isNumber:toBeString]) {
            if (_maxNumberCount > 0) {
                if (toBeString.length > _maxNumberCount) {
                    self.text = [toBeString substringToIndex:_maxNumberCount];
                }
            }else{
                
            }
        }
    }
    
    //区分中英文
    if (_maxCharactersLength > 0) {
        int totalCountAll = [WB_TFTool countTheStrLength:toBeString];
        if (totalCountAll > _maxCharactersLength) {
            int totalCount = 0;
            for (int i = 0; i < toBeString.length; i++) {
                NSString *str1 = [toBeString substringWithRange:NSMakeRange(i, 1)];
                BOOL currentIsCN = [WB_TFTool isChinese:str1]; //当前字符是不是中文
                if (currentIsCN) {
                    totalCount +=2;
                }else{
                    totalCount +=1;
                }
                
                //点击过快，会替换到最后一个字符串？？？为啥？？
                if (totalCount > _maxCharactersLength) {
                    self.text = [toBeString substringToIndex:i];
                    return;
                }
            }
        }
    }
    //不区分中英文
    if (_maxTextLength > 0) {
        if (toBeString.length > _maxTextLength) {
            self.text = [toBeString substringToIndex:_maxTextLength];
        }
    }
    
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

#pragma mark -- Lazy Loading
#pragma mark



@end


@implementation WB_TFTool

+ (BOOL)isChinese:(NSString*)c
{
    int strlength = 0;
    char* p = (char*)[c cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[c lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return ((strlength/2)==1)?YES:NO;
}

+ (int)countTheStrLength:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

+ (void)limitedPointOnlyOne:(UITextField *)tf
{
    NSString *newStr = tf.text;
    NSString *temp = nil;
    int commonWordCount = 0;
    for(int i =0; i < [newStr length]; i++)
    {
        temp = [newStr substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"."]) {
            commonWordCount++;
            if (commonWordCount >= 2) {
                newStr = [newStr substringToIndex:newStr.length-1];
                tf.text = newStr;
            }
        }
        
    }
}

+ (BOOL)isNumber:(NSString *)str
{
    NSString *validRegEx =@"^[0-9]*$";
    NSPredicate *regExPredicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEx];
    BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:str];
    if (myStringMatchesRegEx){
        return YES;
    }else{
        return NO;
    }
}


@end
