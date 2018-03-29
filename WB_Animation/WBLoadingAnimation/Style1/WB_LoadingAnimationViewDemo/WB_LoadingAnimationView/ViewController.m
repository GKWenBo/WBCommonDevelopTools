//
//  ViewController.m
//  WB_LoadingAnimationView
//
//  Created by WMB on 2017/9/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "ViewController.h"
#import "WBLoadingAnimationView.h"
//#import "UIView+WBFrame.h"
#import "UIView+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [WBLoadingAnimationView wb_showLoadingViewWith:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
