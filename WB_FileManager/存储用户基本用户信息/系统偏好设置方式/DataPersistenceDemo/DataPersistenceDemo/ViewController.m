//
//  ViewController.m
//  DataPersistenceDemo
//
//  Created by Admin on 2017/8/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "UserInfoModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UserInfoModel *model = [UserInfoModel new];
    model.nickName = @"保存";
    model.age = @"123456";
    [UserInfoModel wb_saveUserInfo:model];
    
    NSLog(@"save%@",model);
    
    model.isLogin = YES;
    [UserInfoModel wb_saveUserInfo:model];
    [UserInfoModel wb_updateUserInfo:model];
    NSLog(@"update%@",model);
    
    NSLog(@"get%@",[UserInfoModel wb_getUserInfo]);
    
    [UserInfoModel wb_logout];
    NSLog(@"get%@",[UserInfoModel wb_getUserInfo]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
