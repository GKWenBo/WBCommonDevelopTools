//
//  ViewController.m
//  WBTextInputView
//
//  Created by Admin on 2017/11/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "WBTextInputView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)show:(id)sender {
    self.view.backgroundColor = [UIColor whiteColor];
    WBTextInputView *view = [[WBTextInputView alloc]init];
    [view wb_showKeyBoard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
