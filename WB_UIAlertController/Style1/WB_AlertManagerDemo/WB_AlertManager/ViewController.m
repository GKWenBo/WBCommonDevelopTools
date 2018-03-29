//
//  ViewController.m
//  WB_AlertManager
//
//  Created by WMB on 2017/5/16.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "ViewController.h"

#import "WBAlertManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [WB_ALERTMANAGER wb_showAlertWithTitle:@"温馨提示" message:@"测试一下" chooseBlock:^(NSInteger clickedIdx) {
//        NSLog(@"%ld",clickedIdx);
//    } buttonsStatement:@"取消",@"确定",nil];
//    [WB_ALERTMANAGER wb_showActionSheetWithTitle:@"温馨提示" message:@"测试一下" chooseBlock:^(NSInteger clickedIdx) {
//         NSLog(@"%ld",clickedIdx);
//    } cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitle:@"相机",@"图库",nil];
    
//    [WB_ALERTMANAGER wb_showTwoAlertActionWithTitle:@"退出登录" message:nil confirmAction:^{
//        NSLog(@"点击了");
//    }];
    [kWBALERTMANAGER wb_showAutoDismissAlertWithTitle:@"测试一下" message:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
