//
//  ViewController.m
//  WB_LoadingIndicatorView
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "WBLoadingIndicatorView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WBLoadingIndicatorView *cycleView = [[WBLoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    cycleView.center = self.view.center;
    cycleView.speed = 0.5;
    cycleView.circleColor = [UIColor orangeColor];
    [self.view addSubview:cycleView];
    [cycleView startAnimation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
