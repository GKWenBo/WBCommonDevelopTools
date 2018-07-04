//
//  WBTabBarController.m
//  WBAppFrameWorkDemo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBTabBarController.h"

#import "WBDiscoverViewController.h"
#import "WBMeViewController.h"
#import "WBMessageViewController.h"

#import "WBBaseNavigationController.h"

#import "WBTabBar.h"

@interface WBTabBarController () <UITabBarControllerDelegate,WBTabBarDelegate>
#pragma mark ------ < Property > ------
#pragma mark
@property (nonatomic, strong) NSArray *vcArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageNormalArray;
@property (nonatomic, strong) NSArray *imageSelectedArray;
@end

@implementation WBTabBarController

/** << 统一设置外观 > */
+ (void)initialize {
    UITabBarItem * tabbarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    /**  设置字体颜色  */
    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kWB_RGB_COLOR(54, 185, 175)} forState:UIControlStateSelected];
    UITabBar * bar = [UITabBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    /**  设置tabbar颜色  */
    bar.backgroundImage = [UIImage wb_imageWithColor:kWB_RGB_COLOR(249, 249, 249)];
    /**  去掉tabbar线  */
    bar.shadowImage = [[UIImage alloc]init];
}
#pragma mark ------ < Life Cycle > ------
#pragma mark
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
    self.delegate = self;
    [self setupTabBar];
    [self setupChildViewController];
}

#pragma mark ------ < Config ChildViewControllers > ------
#pragma mark
- (void)setupTabBar {
    WBTabBar *tabBar = [[WBTabBar alloc]init];
    tabBar.myDelegate = self;
    /**  < KVC把系统换成自定义 >  */
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)setupChildViewController {
    [self.vcArray enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setupOneChildViewController:vc normalImage:self.imageNormalArray[idx] seletedImage:self.imageSelectedArray[idx] title:self.titleArray[idx]];
    }];
}

- (void)setupOneChildViewController:(UIViewController *)vc
                        normalImage:(NSString *)normalImage
                       seletedImage:(NSString *)seletedImage
                              title:(NSString *)title {
    WBBaseNavigationController *nav = [[WBBaseNavigationController alloc]initWithRootViewController:vc];
    vc.tabBarItem.image = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:seletedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.title = title;
    vc.navigationItem.title = title;
    [self addChildViewController:nav];
}

#pragma mark ------ < WBTabBarDelegate > ------
#pragma mark
- (void)tabBarPlusBtnClicked:(WBTabBar *)tabBar plusBtn:(UIButton *)plusBtn {
    
}

#pragma mark -- UITabBarControllerDelegate
#pragma mark
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
}

- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    return tabBarButton;
}

#pragma mark -- 点击动画
#pragma mark
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
}

#pragma mark -- Getter And Setter
#pragma mark
- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[[WBMeViewController new],
                     [WBDiscoverViewController new]];
    }
    return _vcArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"主页",
                        @"分类",
                        @"消息"];
    }
    return _titleArray;
}

- (NSArray *)imageNormalArray {
    if (!_imageNormalArray) {
        _imageNormalArray = @[@"home_normal",
                              @"fish_normal"];
    }
    return _imageNormalArray;
}

- (NSArray *)imageSelectedArray {
    if (!_imageSelectedArray) {
        _imageSelectedArray = @[@"home_highlight",
                                @"fish_highlight"];
    }
    return _imageSelectedArray;
}

@end
