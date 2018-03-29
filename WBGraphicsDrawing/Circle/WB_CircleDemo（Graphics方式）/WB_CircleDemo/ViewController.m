//
//  ViewController.m
//  WB_CircleDemo
//
//  Created by Admin on 2017/9/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "SolidCircle.h"
#import "HollowCircle.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SolidCircle *circle1 = [[SolidCircle alloc]initWithFrame:CGRectMake(50, 200, 40, 40)];
    [self.view addSubview:circle1];
    
    HollowCircle *circle2 = [[HollowCircle alloc]initWithFrame:CGRectMake(200, 100, 20, 20)];
    circle2.backgroundColor = [UIColor whiteColor];
//    circle2.spacing = 2;
//    circle2.solidCircleColor = [UIColor cyanColor];
    [self.view addSubview:circle2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
