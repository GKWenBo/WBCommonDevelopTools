//
//  ViewController.m
//  Demo
//
//  Created by WMB on 2017/10/6.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "ViewController.h"
#import "WBCommonUtility.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@",[kWBCOMMONUTILITY wb_getNumberArrayWithNumbers:1156]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
