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
    view.datePickerStyle = WB_ShowDateYearMonthDayStyle;
    view.contentMode = WBPickerContentModeBottom;
    view.minLimitDate = [NSDate date];
    view.maxLimitDate = [NSDate date:@"2018-01-02 00:00" WithFormat:@"yyyy-MM-dd HH:mm"];
    view.DateSelectedBlock = ^(NSString *dateStr, NSDate *date) {
        NSLog(@"%@-----%@",dateStr,date);
    };
    [view show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
