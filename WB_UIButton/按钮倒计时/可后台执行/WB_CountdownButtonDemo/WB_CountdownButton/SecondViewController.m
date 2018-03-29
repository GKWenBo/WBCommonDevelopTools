//
//  SecondViewController.m
//  单例实现验证码按钮倒计时Demo
//
//  Created by WMB on 2016/11/27.
//  Copyright © 2016年 文波. All rights reserved.
//

#import "SecondViewController.h"
#import "WBCountdownButton.h"
@interface SecondViewController ()
@property (nonatomic,strong) WBCountdownButton * button1;
@property (nonatomic,strong) WBCountdownButton * button2;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _button1 = [[WBCountdownButton alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    _button1.center = CGPointMake(self.view.center.x, self.view.center.y);
    [_button1 setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    _button1.backgroundColor = [UIColor orangeColor];
    [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _button1.identifyKey = @"orangekey";
    _button1.countDownTime = 5;
    _button1.disabledTitleColor = [UIColor whiteColor];
    _button1.disabledBackgroundColor = [UIColor grayColor];
    [self.view addSubview:_button1];
    
    _button2 = [[WBCountdownButton alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    _button2.center = CGPointMake(self.view.center.x, self.view.center.y + 60);
    [_button2 setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    _button2.backgroundColor = [UIColor clearColor];
    [_button2 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [_button2 addTarget:self action:@selector(button2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    _button2.countDownTime = 10;
    _button2.identifyKey = @"cykey";
    _button2.disabledTitleColor = [UIColor grayColor];
    [self.view addSubview:_button2];
    
}

#pragma mark -- BtnAction
#pragma mark
- (void)button1Clicked:(WBCountdownButton *)sender {
    
    [sender wb_timeFire];
}

- (void)button2Clicked:(WBCountdownButton *)sender {
    
    [sender wb_timeFire];
}



@end
