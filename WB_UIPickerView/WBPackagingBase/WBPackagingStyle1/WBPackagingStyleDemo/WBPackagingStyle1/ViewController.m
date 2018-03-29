//
//  ViewController.m
//  WBPackagingStyle1
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "ViewController.h"
#import "WBBasePickerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)show:(id)sender {
    WBBasePickerView * picker = [WBBasePickerView new];
    picker.titleColor = [UIColor orangeColor];
    picker.dismissimeInterval = 0.15;
    picker.contentHeight = 300;
    picker.contentMode = WBPickerContentModeBottom;
    picker.title = @"请选择";
    
    [picker show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
