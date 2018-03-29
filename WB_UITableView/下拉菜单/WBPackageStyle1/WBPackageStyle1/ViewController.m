//
//  ViewController.m
//  WBPackageStyle1
//
//  Created by Admin on 2017/10/27.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "DropDownListView.h"
static NSInteger const kDropDownViewHeight = 40;
/**
 *  屏幕宽高
 */
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
@interface ViewController () <DropDownChooseDataSource,DropDownChooseDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}

- (void)setupUI {
    DropDownListView *view = [[DropDownListView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, kDropDownViewHeight) dataSource:self delegate:self];
    view.mSuperView = self.view;
    [self.view addSubview:view];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + 40 - 0.5, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
}

#pragma mark -- DropDownChooseDataSource
#pragma mark
- (NSInteger)numberOfSections {
    return 4;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 6;
    }
    return 2;
}
- (NSString *)titleInSection:(NSInteger)section index:(NSInteger)index {
    return [NSString stringWithFormat:@"测试%ld",index];
}
- (NSString *)defaultTitleInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"测试%ld",section];
}
#pragma mark -- dropDownListDelegate
#pragma mark
//点击了某行
- (void)chooseAtSection:(NSInteger)section index:(NSInteger)index {
    NSLog(@"section:%ld----index:%ld",section,index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
