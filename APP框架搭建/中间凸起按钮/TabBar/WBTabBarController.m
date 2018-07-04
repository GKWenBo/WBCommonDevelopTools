//
//  WBTabBarController.m
//  WBAppFrameWorkDemo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBTabBarController.h"

#import "WBHomeViewController.h"
#import "WBMeViewController.h"
#import "WBMessageViewController.h"
#import "WBManitoViewController.h"
#import "WBTeamViewController.h"

#import "WBBaseNavigationController.h"

#import "WBTabBar.h"

@interface WBTabBarController () <WBTabBarDelegate>
#pragma mark ------ < Property > ------
#pragma mark
@property (nonatomic, strong) NSArray *vcArray;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation WBTabBarController

/** << 统一设置外观 > */
+ (void)initialize {
//    UITabBarItem * tabbarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
//    /**  设置字体颜色  */
//    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kWB_RGB_COLOR(54, 185, 175)} forState:UIControlStateSelected];
    UITabBar * bar = [UITabBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    /**  设置tabbar颜色  */
    bar.backgroundImage = [UIImage wb_imageWithColor:[UIColor whiteColor]];
    /**  去掉tabbar线  */
    bar.shadowImage = [[UIImage alloc]init];
}
#pragma mark ------ < Life Cycle > ------
#pragma mark
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self wb_removeTabbarButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeUserInterface];
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
#pragma mark ------ < 初始化 > ------
#pragma mark
- (void)initializeDataSource {
    
}

- (void)initializeUserInterface {
    [self setupTabBar];
    [self setupChildViewController];
}

#pragma mark ------ < Config ChildViewControllers > ------
#pragma mark
- (void)setupTabBar {
    WBTabBar *tabBar = [[WBTabBar alloc]initWithFrame:self.tabBar.bounds];
    tabBar.myDelegate = self;
    /**  < KVC把系统换成自定义 >  */
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)setupChildViewController {
    [self.vcArray enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setupOneChildViewController:vc title:self.titleArray[idx]];
    }];
}

- (void)setupOneChildViewController:(UIViewController *)vc
                              title:(NSString *)title {
    WBBaseNavigationController *nav = [[WBBaseNavigationController alloc]initWithRootViewController:vc];
//    vc.navigationItem.title = title;
    [self addChildViewController:nav];
}

#pragma mark ------ < WBTabBarDelegate > ------
#pragma mark
- (void)wb_tabBarPlusBtnClicked:(WBTabBar *)tabBar selectedIndex:(NSInteger)selectedIndex isPlusBtn:(BOOL)isPlusBtn {
    
    self.selectedIndex = selectedIndex;
}

#pragma mark -- Getter And Setter
#pragma mark
- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[[WBHomeViewController new],
                     [WBTeamViewController new],
                     [WBManitoViewController new],
                     [WBMessageViewController new],
                     [WBMeViewController new]];
    }
    return _vcArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"首页",
                        @"组队",
                        @"大神",
                        @"消息",
                        @"我的"];
    }
    return _titleArray;
}

@end
