//
//  ViewController.m
//  MyDemo
//
//  Created by Admin on 2017/11/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "WBLocalWebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WBLocalWebViewController *web = [[WBLocalWebViewController alloc]initWithfileType:WBLocalHTMLFileType fileName:@"agree_wallet"];
    [self.navigationController pushViewController:web animated:YES];
}


@end
