//
//  ViewController.m
//  WB_CountdownButton
//
//  Created by WMB on 2017/6/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)next:(id)sender {
    
    SecondViewController * vc = [SecondViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
