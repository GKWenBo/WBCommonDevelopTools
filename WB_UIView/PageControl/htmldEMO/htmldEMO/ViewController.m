//
//  ViewController.m
//  htmldEMO
//
//  Created by WenBo on 2019/10/28.
//  Copyright © 2019 wenbo. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebView *webview = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    webview.backgroundColor = [UIColor redColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jmwDemo" ofType:@"html"];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    [self.view addSubview:webview];
}
@end
