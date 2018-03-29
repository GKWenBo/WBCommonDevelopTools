//
//  ViewController.m
//  WB_PopupView1
//
//  Created by WMB on 2017/6/12.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "ViewController.h"

#import "WBBasePopupView.h"

@interface ViewController ()
{
    WBBasePopupView  * view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)show:(id)sender {
    view = [WBBasePopupView new];
    view.contentSize = CGSizeMake(400, 400);
    view.animationStyle = WBShowHUDPositionStyleDefault;
    [view wb_showHUDAnimation];
}
- (IBAction)hide:(id)sender {
    [view wb_hideHUDAnimation];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
