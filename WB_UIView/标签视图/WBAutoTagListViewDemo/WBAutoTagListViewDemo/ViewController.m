//
//  ViewController.m
//  WBAutoTagListViewDemo
//
//  Created by wenbo on 2018/6/6.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "ViewController.h"
#import "WBTagListItem.h"
#import "Masonry.h"
#import "WBAutoTagListView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
    
    WBAutoTagListView *item = [[WBAutoTagListView alloc]init];
    item.items = @[@"测试",@"测试",@"测试",@"测试测试测试测试测试",@"测试",@"测试",@"测试测试测试测试测试",@"测试",@"测试"];
    item.itemHeight = 50;
    item.leftMargin = 35;
    item.titleColor = [UIColor orangeColor];
    item.borderWidth = 1;
    item.font = [UIFont systemFontOfSize:20.f];
    [self.view addSubview:item];
    
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(80);
        make.right.mas_offset(-10);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
