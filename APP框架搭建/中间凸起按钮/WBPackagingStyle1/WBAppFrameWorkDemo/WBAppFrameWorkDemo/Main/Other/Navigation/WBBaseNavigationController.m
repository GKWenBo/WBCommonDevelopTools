//
//  WBBaseNavigationController.m
//  WBAppFrameWorkDemo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBBaseNavigationController.h"

@interface WBBaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation WBBaseNavigationController

/** << 统一设置外观 > */
+ (void)initialize {
    UIBarButtonItem * barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    /**  设置UIBarButtonItem 字体颜色和大小  */
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
    UINavigationBar * bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    /**  设置中间标题颜色和字体大小  */
    bar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : kWB_PFR_FONT(17)};
    /**  去掉导航线  */
    bar.shadowImage = [[UIImage alloc]init];
    /**  设置导航栏颜色  */
    [bar setBackgroundImage:[UIImage wb_imageWithColor:kWB_RGB_COLOR(54, 185, 175)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark ------ < UIGestureRecognizerDelegate > ------
#pragma mark
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        NSString *title = @"返回";
        if (self.childViewControllers.count == 1) {
            title = self.childViewControllers.firstObject.title;
        }
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
