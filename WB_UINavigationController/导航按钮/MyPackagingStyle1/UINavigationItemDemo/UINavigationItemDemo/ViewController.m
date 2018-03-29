//
//  ViewController.m
//  UINavigationItemDemo
//
//  Created by WMB on 2017/9/26.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "ViewController.h"
#import "UIBarButtonItem+WBCreate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view, typically from a nib.
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(popAction) image:[UIImage imageNamed:@"nav_back"]];
    }
}

- (void)popAction {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewController *vc = [ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
