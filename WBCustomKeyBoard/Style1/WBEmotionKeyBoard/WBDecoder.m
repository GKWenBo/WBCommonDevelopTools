//
//  WB_Decoder.m
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBDecoder.h"
#import "WBTextAttachment.h"
#import "YYImage.h"
#import "YYText.h"

static CGSize                    _emotionSize;
static UIFont                    *_font;
static UIColor                   *_textColor;
static NSArray                   *_matches;
static NSString                  *_string;
static NSDictionary              *_emojiImages;
static NSMutableArray            *_imageDataArray;
static NSMutableAttributedString *_attStr;
static NSMutableAttributedString *_resultStr;

static NSString *const checkStr = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";

@implementation WBDecoder


+ (NSMutableAttributedString *)decodeWithPlainStr:(NSString *)plainStr font:(UIFont *)font {
    
    if (!plainStr) {return [[NSMutableAttributedString alloc]initWithString:@""];}else {
        
        _font      = font;
        _string    = plainStr;
        _textColor = [UIColor blackColor];
        [self initProperty];
        [self executeMatch];
        [self setImageDataArray];
        [self setResultStrUseReplace];
        return _resultStr;
    }
}

+ (void)initProperty {
    
    // 读取并加载对照表
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LiuqsEmotions" ofType:@"plist"];
    _emojiImages = [NSDictionary dictionaryWithContentsOfFile:path];
    //文本间隔
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4.0f];
    
    NSDictionary *dict = @{NSFontAttributeName:          _font,
                           NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize maxsize = CGSizeMake(1000, MAXFLOAT);
    
    _emotionSize = [@"/" boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    _attStr = [[NSMutableAttributedString alloc]initWithString:_string attributes:dict];
}

+ (void)executeMatch {
    
    //比对结果
    NSString *regexString = checkStr;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSRange totalRange = NSMakeRange(0, [_string length]);
    
    _matches = [regex matchesInString:_string options:0 range:totalRange];
}

+ (void)setImageDataArray {
    
    NSMutableArray *imageDataArray = [NSMutableArray array];
    //遍历结果
    for (int i = (int)_matches.count - 1; i >= 0; i --) {
        
        NSMutableDictionary *record = [NSMutableDictionary dictionary];
        
        WBTextAttachment *attachMent = [[WBTextAttachment alloc]init];
        
        attachMent.bounds = CGRectMake(0, -4, _emotionSize.height, _emotionSize.height);
        
        NSTextCheckingResult *match = [_matches objectAtIndex:i];
        
        NSRange matchRange = [match range];
        
        NSString *tagString = [_string substringWithRange:matchRange];
        
        NSString *imageName = [_emojiImages objectForKey:tagString];
        
        if (imageName == nil || imageName.length == 0) continue;
        
        [record setObject:[NSValue valueWithRange:matchRange] forKey:@"range"];
        
        [record setObject:imageName forKey:@"imageName"];
        
        [imageDataArray addObject:record];
    }
    _imageDataArray = imageDataArray;
}

+ (void)setResultStrUseReplace{
    
    NSMutableAttributedString *result = _attStr;
    
    for (int i = 0; i < _imageDataArray.count ; i ++) {
        
        NSRange range = [_imageDataArray[i][@"range"] rangeValue];
        
        NSDictionary *imageDic = [_imageDataArray objectAtIndex:i];
        
        NSString *imageName = [imageDic objectForKey:@"imageName"];
        
        NSString *path = [[NSBundle mainBundle]pathForResource:imageName ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        YYImage *image = [YYImage imageWithData:data scale:2];
        
        image.preloadAllAnimatedImageFrames = YES;
        
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.frame.size alignToFont:_font alignment:YYTextVerticalAlignmentCenter];
        
        [result replaceCharactersInRange:range withAttributedString:attachText];
    }
    _resultStr = result;
}

@end
