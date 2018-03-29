//
//  ViewController.m
//  WBImageZoomingDemo
//
//  Created by WMB on 2017/10/31.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "ViewController.h"
#import "WBZoomingImageViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WBZoomingImageViewController *vc = [WBZoomingImageViewController new];
    vc.zoomImage =[UIImage imageNamed:@"test2"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
