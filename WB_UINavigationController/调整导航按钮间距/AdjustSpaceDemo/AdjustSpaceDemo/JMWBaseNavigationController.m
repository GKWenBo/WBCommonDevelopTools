//
//  JMWBaseNavigationController.m
//  Start
//
//  Created by Mr_Lucky on 2018/10/31.
//  Copyright © 2018 jmw. All rights reserved.
//

#import "JMWBaseNavigationController.h"

@interface JMWBaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation JMWBaseNavigationController

// MARK:Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
    /*  < 开启全局管理导航栏 > */
    self.fd_viewControllerBasedNavigationBarAppearanceEnabled = NO;
}

// MARK:UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
