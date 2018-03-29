//
//  ViewController.m
//  Demo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "ViewController.h"
#import "WBSingleComponentPickerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)show:(id)sender {
    WBSingleComponentPickerView * view = [WBSingleComponentPickerView new];
    view.isNeedUnit = YES;
    view.unitString = @"人";
    view.dataArray = @[@"男",@"女"];
    view.SelectedBlock = ^(NSInteger row, NSString *selectData) {
        NSLog(@"%ld---%@",row,selectData);
    };
    [view show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
