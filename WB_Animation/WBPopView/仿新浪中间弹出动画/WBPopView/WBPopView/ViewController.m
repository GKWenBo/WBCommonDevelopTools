//
//  ViewController.m
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import "ViewController.h"
#import "WBPublishPopView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showAction:(id)sender {
    [WBPublishPopView wb_showToView:[UIApplication sharedApplication].keyWindow andImages:@[@"textPublish_icon",@"imagePublish_icon",@"videoPublish_icon"] andTitles:@[@"图文",@"图片",@"视频"] andSelectBlock:^(WBPublishPopItem *item) {
        NSLog(@"%@",item.title);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
