//
//  WBBasePublicViewController.m
//  WBAppFrameWorkDemo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBBasePublicViewController.h"

@interface WBBasePublicViewController ()

@property (nonatomic,strong) UIButton *naviBackButton;

@end

@implementation WBBasePublicViewController

- (void)dealloc {
    DLog(@"");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self wb_defaultConfig];
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
    [self wb_loadData];
}

- (void)initializeUserInterface {
    
}

#pragma mark ------ < Default Config > ------
#pragma mark
- (void)wb_defaultConfig {
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0,*)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (self.navigationController.viewControllers.count > 1) {
        [self wb_setNavigationBackButton];
    }
}

- (void)wb_setNavigationBackButton {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:self.naviBackButton];
    self.navigationItem.leftBarButtonItem = barButton;
}

- (void)wb_resetNavigationButtonImage:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    [self.naviBackButton setImage:image forState:UIControlStateNormal];
    [self.naviBackButton setImage:image forState:UIControlStateHighlighted];
    self.naviBackButton.frame = CGRectMake(0, 0, image.size.width, 40);
}

#pragma mark ------ < NetWork > ------
#pragma mark
- (void)wb_addScrollViewHeaderRefresh:(id)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)scrollView;
        tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(wb_loadData)];
    } else if ([scrollView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *tableview = (UICollectionView *)scrollView;
        tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(wb_loadData)];
    }
}

- (void)wb_addScrollViewHeaderFooterRefresh:(id)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)scrollView;
        tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(wb_loadData)];
        MJRefreshAutoNormalFooter * footer  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(wb_loadMoreData)];
        [footer setTitle:@"这是我们的底线" forState:MJRefreshStateNoMoreData];
        tableview.mj_footer = footer;
        tableview.mj_footer.hidden = YES;
    } else if ([scrollView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *tableview = (UICollectionView *)scrollView;
        tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(wb_loadData)];
        MJRefreshAutoNormalFooter * footer  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(wb_loadMoreData)];
        tableview.mj_footer = footer;
        tableview.mj_footer.hidden = YES;
    }
}

- (void)wb_loadData {
    
}

- (void)wb_loadMoreData {
    
}

#pragma mark ------ < Event Response > ------
#pragma mark
- (void)wb_navigationButtonClicked:(UIButton *)sender {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

#pragma mark ------ < Getter > ------
#pragma mark
- (UIButton *)naviBackButton {
    if (!_naviBackButton) {
        UIImage *image = [UIImage imageNamed:@"back_topre"];
        _naviBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_naviBackButton setImage:image forState:UIControlStateNormal];
        [_naviBackButton setImage:image forState:UIControlStateHighlighted];
        _naviBackButton.frame = CGRectMake(0, 0, 40, 40);
        _naviBackButton.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        [_naviBackButton addTarget:self action:@selector(wb_navigationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBackButton;
}

@end
