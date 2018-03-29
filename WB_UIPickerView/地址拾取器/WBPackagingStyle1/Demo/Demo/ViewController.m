//
//  ViewController.m
//  Demo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "ViewController.h"
#import "WBAddressPickerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)show:(id)sender {
    WBAddressPickerView * view = [[WBAddressPickerView alloc]init];
    //    [view configDataProvince:@"四川省" cityName:@"成都市" areaName:@"武侯区"];
    view.block = ^(NSString *province, NSString *city, NSString *area) {
        NSLog(@"%@ %@ %@",province,city,area);
    };
    [view show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
