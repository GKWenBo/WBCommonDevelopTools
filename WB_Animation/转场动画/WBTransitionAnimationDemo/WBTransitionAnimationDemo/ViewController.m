//
//  ViewController.m
//  WBTransitionAnimationDemo
//
//  Created by wenbo on 2022/3/11.
//

#import "ViewController.h"

#import "WBCustomPresentViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WBCustomPresentViewController *vc = [[WBCustomPresentViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
