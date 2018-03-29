//
//  WBLocalWebViewController.h
//  MyDemo
//
//  Created by Admin on 2017/11/9.
//  Copyright © 2017年 Admin. All rights reserved.
//


#import <UIKit/UIKit.h>

/**  < 本地文件枚举 >  */
typedef NS_ENUM(NSInteger, WBLocalFileType) {
    WBLocalHTMLFileType,        /**  < 本地网页 >  */
    WBLocalRTFFileType,         /**  < Rtf文件 >  */
    WBLocalTEXTFileType,        /**  < 文本文件 >  */
    WBLocalPDFFileType          /**  < PDF文件 >  */
};


@interface WBLocalWebViewController : UIViewController

/**
 初始化方法

 @param fileType fileType description
 @param fileName fileName description
 @return WBLocalWebViewController
 */
- (instancetype)initWithfileType:(WBLocalFileType)fileType
                        fileName:(NSString *)fileName;

@end
