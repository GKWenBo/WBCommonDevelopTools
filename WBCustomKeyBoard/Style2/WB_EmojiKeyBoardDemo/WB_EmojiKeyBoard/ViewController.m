//
//  ViewController.m
//  WB_EmojiKeyBoard
//
//  Created by WMB on 2017/9/17.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "ViewController.h"
#import "WBInputBar.h"

@interface ViewController ()

@end

@implementation ViewController
{
    WBInputBar *_inputBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _inputBar = [WBInputBar inputBar];
    _inputBar.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.bounds)-CGRectGetHeight(_inputBar.frame)+CGRectGetHeight(_inputBar.frame)/2);
    [_inputBar setFitWhenKeyboardShowOrHide:YES];
    _inputBar.placeHolder = @"小明的故事...";
    
    [self.view addSubview:_inputBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
