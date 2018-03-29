//
//  ViewController.m
//  MyPackagingStyle1
//
//  Created by Admin on 2017/10/25.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "WBAutoAdjustWebView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WBAutoAdjustWebView *webView = [[WBAutoAdjustWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
