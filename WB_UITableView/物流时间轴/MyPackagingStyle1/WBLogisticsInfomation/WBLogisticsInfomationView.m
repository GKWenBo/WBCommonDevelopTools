//
//  WB_LogisticsInfomationView.m
//  WB_LogisticsInfomationDemo
//
//  Created by Admin on 2017/7/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBLogisticsInfomationView.h"
#import "WBLogisticsInfomationConfig.h"
#import "WBLogisticsInfomationCell.h"
static NSString * kIdentifier = @"WBLogisticsInfomationCell";
@interface WBLogisticsInfomationView () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation WBLogisticsInfomationView

#pragma mark -- 视图初始化
#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithDataArray:(NSArray *)array {
    self = [super init];
    if (self) {
        [self.dataArray addObjectsFromArray:array];
    }
    return self;
}

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    [self addSubview:self.tableView];
    [self.tableView registerClass:[WBLogisticsInfomationCell class] forCellReuseIdentifier:kIdentifier];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
}


#pragma mark -- 赋值
#pragma mark
- (void)reloadWithDataArray:(NSArray *)dataArrray {
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArrray];
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
#pragma mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBLogisticsInfomationCell * cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.hasUpLine = NO;
        cell.currented = NO;
    } else {
        cell.hasUpLine = YES;
        cell.currented = NO;
    }
    
    if (indexPath.row == self.dataArray.count - 1) {
        cell.hasDownLine = NO;
        cell.currented = YES;
    }else {
        cell.hasDownLine = YES;
    }
    
    WBLogisticsInfomationModel * model = self.dataArray[indexPath.row];
    [cell configData:model];
    return cell;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark -- Getter And Setter
#pragma mark
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50.f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)setDataSource:(NSArray *)dataSource {
    if (_dataSource == dataSource) {
        _dataSource = dataSource;
    }
    [self.tableView reloadData];
}
@end
