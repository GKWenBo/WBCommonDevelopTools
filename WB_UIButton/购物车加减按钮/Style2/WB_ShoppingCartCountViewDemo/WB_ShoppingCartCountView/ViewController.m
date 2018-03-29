//
//  ViewController.m
//  WB_ShoppingCartCountView
//
//  Created by WMB on 2017/6/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "ViewController.h"

#import "WBShoppingCartCountView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建对象
    WBShoppingCartCountView *btn = [[WBShoppingCartCountView alloc] init];
    
    // 设置Frame，如不设置则默认为(0, 0, 110, 30)
    btn.lineColor = [UIColor orangeColor];
    btn.maxCount = @"10";
    btn.frame = CGRectMake(100, 200, 150, 40);
    
    // 内容更改的block回调
    btn.CurrentCountBlock = ^(NSString *count) {
        
        NSLog(@"%@",count);
    };
    
    // 加到父控件上
    [self.view addSubview:btn];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
