//
//  ViewController.m
//  Demo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "ViewController.h"
#import "WBDatePickerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)show:(id)sender {
    WBDatePickerView * view = [WBDatePickerView new];
    view.title = @"请选择日期";
    //    view.contentMode = WBPickerContentModeCenter;
    view.DidSelectedDateBlock = ^(NSString * _Nonnull dateString, NSDate * _Nonnull date) {
        NSLog(@"%@",dateString);
    };
    [view show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
