//
//  ViewController.m
//  WB_DrawLineDemo
//
//  Created by Admin on 2017/9/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "DrawLine.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DrawLine *line = [[DrawLine alloc]initWithFrame:CGRectMake(100, 50, 100, 100)];
    [self.view addSubview:line];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
