//
//  ViewController.m
//  FPSLabel
//
//  Created by wenbo on 2018/5/14.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "ViewController.h"
#import "YYFPSLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YYFPSLabel *label = [[YYFPSLabel alloc]initWithFrame:CGRectMake(100, 100, 0, 0)];
    [self.view addSubview:label];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
