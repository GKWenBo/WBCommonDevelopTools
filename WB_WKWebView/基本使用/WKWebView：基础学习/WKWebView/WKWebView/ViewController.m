//
//  ViewController.m
//  WKWebView
//
//  Created by WMB on 2016/11/10.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "ViewController.h"

#import <WebKit/WebKit.h> //导入库
@interface ViewController () <WKNavigationDelegate>

#pragma mark -- Property
#pragma mark
@property (nonatomic,strong) WKWebView * webView;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,strong) UIActivityIndicatorView * activityView;


- (void)initDataSource;
- (void)initLizeInterface;
@end
#pragma mark -- LifeCycle
#pragma mark
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initLizeInterface];
}

#pragma mark -- 初始化
#pragma mark
- (void)initDataSource {


}
- (void)initLizeInterface {
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.activityView];
}


#pragma mark -- WKNavigationDelegate,WKUIDelegate
#pragma mark
/**  页面开始加载时调用  */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始了");
    [self.activityView startAnimating];
}

/**  当内容开始返回时调用  */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
/**  页面加载完成之后调用  */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"结束了");
    
    [self.activityView stopAnimating];
}
/**  页面加载失败时调用  */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}

#pragma mark -- WKNavigtionDelegate来进行页面跳转
#pragma mark
///**  接收到服务器跳转请求之后再执行  */
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
//    
//}
///**  在收到响应后，决定是否跳转  */
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    
//}
///**  在发送请求之前，决定是否跳转  */
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    
//}

#pragma mark --  WKUIDelegate
#pragma mark
//1.创建一个新的WebVeiw
//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//    
//}
//2.WebVeiw关闭（9.0中的新方法）
//- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0) {
//    
//}
////3.显示一个JS的Alert（与JS交互）
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
//    
//}
////4.弹出一个输入框（与JS交互的）
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
//    
//}
////5.显示一个确认框（JS的）
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
//    
//}

#pragma mark -- 懒加载
#pragma mark
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:self.view.frame];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        _webView.navigationDelegate = self;
//        _webView.UIDelegate = self;
        
    }
    return _webView;
}

- (NSString *)url {
    if (!_url) {
        _url = @"https://www.baidu.com";
    }
    return _url;
}
- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.bounds = CGRectMake(0, 0, 45, 45);
        _activityView.center = self.view.center;
        //设置指示器颜色
        _activityView.color = [UIColor grayColor];
    }
    return _activityView;
}

@end
