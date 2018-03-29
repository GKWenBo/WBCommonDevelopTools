//
//  WBLocalWebViewController.m
//  MyDemo
//
//  Created by Admin on 2017/11/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBLocalWebViewController.h"

@interface WBLocalWebViewController () <UIWebViewDelegate>

{
    WBLocalFileType _fileType;
    NSString *_fileName;
}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation WBLocalWebViewController

#pragma mark ------ < 初始化方法 > ------
#pragma mark
- (instancetype)initWithfileType:(WBLocalFileType)fileType
                        fileName:(NSString *)fileName {
    self = [super init];
    if (self) {
        NSAssert(fileName.length > 0, @"请设置文件名");
        _fileName = fileName;
        _fileType = fileType;
        [self setupWebView];
    }
    return self;
}

#pragma mark ------ < Life Cycle > ------
#pragma mark
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initializeDataSource];
    [self initializeUserInterface];
}

#pragma mark ------ < Initialize > ------
#pragma mark
- (void)initializeDataSource {
    
}

- (void)initializeUserInterface {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.indicatorView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------ < Request > ------
#pragma mark

#pragma mark ------ < Event Response > ------
#pragma mark

#pragma mark ------ < Private Method > ------
#pragma mark
- (void)setupWebView {
    self.webView.frame = self.view.frame;
    [self.view addSubview:self.webView];
    
    NSString *typeStr = @"";
    switch (_fileType) {
        case WBLocalPDFFileType:
            typeStr = @"pdf";
            break;
        case WBLocalRTFFileType:
            typeStr = @"rtf";
            break;
        case WBLocalHTMLFileType:
            typeStr = @"html";
            break;
        case WBLocalTEXTFileType:
            typeStr = @"txt";
            break;
        default:
            break;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:_fileName ofType:typeStr];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark ------ < UIWebViewDelegate > ------
#pragma mark
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.indicatorView stopAnimating];
}

#pragma mark ------ < Lazy Loading > ------
#pragma mark
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectZero];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.opaque = NO;
        _webView.delegate = self;
        _webView.scalesPageToFit = NO;
        _webView.dataDetectorTypes = UIDataDetectorTypeNone;
        if (@available(iOS 11.0,*)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = self.view.center;
    }
    return _indicatorView;
}

@end
