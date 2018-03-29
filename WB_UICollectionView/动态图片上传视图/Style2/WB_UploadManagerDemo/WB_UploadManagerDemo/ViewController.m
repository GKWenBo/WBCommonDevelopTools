//
//  ViewController.m
//  WB_UploadManagerDemo
//
//  Created by Admin on 2017/7/11.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "WBUploadView.h"
#import "Masonry.h"
#import "UIView+WBFrame.h"
@interface ViewController () <WB_UploadViewDelegate>
{
    WBUploadView * upLoadView;
    NSMutableArray * dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    dataArray = [@[@"1",@"2",@"3",@"4",@"2",@"3",@"4"] mutableCopy];
    upLoadView  = [[WBUploadView alloc]initWithFrame:CGRectZero maxNumRows:3 rowCount:0 maxCount:0 leftRightMargin:0 topBottomMargin:0 itemSpacing:15];
    upLoadView.imageDataArray = dataArray;
    upLoadView.delegate = self;
    [self.view addSubview:upLoadView];
    
    [upLoadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(64);
        make.height.mas_equalTo(upLoadView.height);
    }];
}

- (void)wb_upLoadView:(WBUploadView *)wb_upLoadView deleteIdx:(NSInteger)deleteIdx {
    [dataArray removeObjectAtIndex:deleteIdx];
    [self wb_updateConstraints];
}

- (void)wb_addCellClicked {
    NSLog(@"点击添加了");
    [dataArray addObject:@"1"];
    upLoadView.imageDataArray = dataArray;
    [self wb_updateConstraints];
}

#pragma mark -- 更新约束
#pragma mark
- (void)wb_updateConstraints {
    [upLoadView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(upLoadView.height);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
