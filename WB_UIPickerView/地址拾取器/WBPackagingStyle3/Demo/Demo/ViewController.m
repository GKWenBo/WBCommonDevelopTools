//
//  ViewController.m
//  Demo
//
//  Created by WMB on 2017/10/11.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "ViewController.h"
#import "WBAreaPickerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)show:(id)sender {
    WBAreaPickerView * view = [WBAreaPickerView new];
    view.selectedArea = ^(NSString *province, NSString *city, NSString *area) {
        NSLog(@"%@ %@ %@",province,city,area);
    };
    [view show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
