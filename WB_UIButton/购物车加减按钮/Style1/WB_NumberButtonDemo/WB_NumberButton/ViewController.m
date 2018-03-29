//
//  ViewController.m
//  WB_NumberButton
//
//  Created by WMB on 2017/6/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "ViewController.h"
#import "WBNumberButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    
    [self example1];
    
    [self example2];
    
    [self example3];
}

//默认状态
- (void)example1
{
    WBNumberButton *numberButton = [[WBNumberButton alloc] initWithFrame:CGRectMake(100, 100, 110, 30)];
    //开启抖动动画
    numberButton.number = @"22";
    numberButton.shakeAnimation = YES;
    numberButton.CountChangeBlock = ^(NSString *count) {
        NSLog(@"%@",count);
    };
    
    [self.view addSubview:numberButton];
}
//边框状态
- (void)example2
{
    WBNumberButton *numberButton = [[WBNumberButton alloc] initWithFrame:CGRectMake(100, 160, 200, 30)];
    //设置边框颜色
    numberButton.borderColor = [UIColor grayColor];
    
    numberButton.CountChangeBlock = ^(NSString *count) {
        NSLog(@"%@",count);
    };
    
    [self.view addSubview:numberButton];
}
//自定义加减按钮的文字
- (void)example3
{
    WBNumberButton *numberButton = [[WBNumberButton alloc] initWithFrame:CGRectMake(100, 220, 150, 44)];
    numberButton.shakeAnimation = YES;
    //设置边框颜色
    numberButton.borderColor = [UIColor grayColor];
    //设置加减按钮文字
    [numberButton wb_setIncreaseTitle:@"加" decreaseTitle:@"减"];
    
    numberButton.CountChangeBlock = ^(NSString *count) {
        NSLog(@"%@",count);
    };
    
    [self.view addSubview:numberButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
