//
//  WBAutoAdjustWebView.m
//  MyPackagingStyle1
//
//  Created by Admin on 2017/10/25.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBAutoAdjustWebView.h"

@implementation WBAutoAdjustWebView

#pragma mark ------ < 初始化 > ------
#pragma mark
- (instancetype)initWithFrame:(CGRect)frame
{
    //创建WKWebview配置对象
    WKWebViewConfiguration*config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.minimumFontSize = 14.f;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    config.dataDetectorTypes = WKDataDetectorTypeNone;
    NSMutableString *javascript = [NSMutableString string];
    /**  < 禁止长按 >  */
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];
    /**  < 禁止选择 >  */
    [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];
    /**  < 关闭缩放与自适应屏幕大小 >  */
    [javascript appendString:@"var meta = document.createElement('meta'); \
     meta.name = 'viewport'; \
     meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
     var head = document.getElementsByTagName('head')[0];\
     head.appendChild(meta);"];
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    self = [super initWithFrame:frame configuration:config];
    if (self) {
        [self.configuration.userContentController addUserScript:noneSelectScript];
        if (@available(iOS 11.0,*)) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}


@end
