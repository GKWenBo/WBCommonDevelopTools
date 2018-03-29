//
//  NSAttributedString+WB_Extension.m
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "NSAttributedString+WBExtension.h"
#import "WBTextAttachment.h"

@implementation NSAttributedString (WBExtension)

//遍历替换图片得到普通字符
- (NSString *)getPlainString {
    
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(WBTextAttachment *value, NSRange range, BOOL *stop) {
                      if (value) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:value.emojiTag];
                          base += value.emojiTag.length - 1;
                      }
                  }];
    return plainString;
}


@end
