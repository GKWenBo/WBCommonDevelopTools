//
//  WB_Decoder.h
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

/***********************这是一个转码工具类***************************/

@interface WBDecoder : NSObject

/*
 * 转码方法，把普通字符串转为富文本字符串（包含图片文字等）
 * 参数 font 是用来展示的字体大小
 * 参数 plainStr 是普通的字符串
 * 返回值：用来展示的富文本，直接复制给label展示
 */
+ (NSMutableAttributedString *)decodeWithPlainStr:(NSString *)plainStr font:(UIFont *)font;

@end
