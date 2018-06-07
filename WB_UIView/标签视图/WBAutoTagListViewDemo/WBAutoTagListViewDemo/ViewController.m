//
//  ViewController.m
//  WBAutoTagListViewDemo
//
//  Created by wenbo on 2018/6/6.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "ViewController.h"
#import "WBAutoTagListView.h"
#import "WBTagListViewCell.h"

static NSString *kIdentifier = @"cell";


@interface ViewController () <UITableViewDelegate,UITableViewDataSource,WBTagListViewCellDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    [self initDataSource];

    [self initTableView];
    
}

- (void)initTableView {
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 90;
    [_tableView registerClass:[WBTagListViewCell class] forCellReuseIdentifier:kIdentifier];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:_tableView];
}

- (void)initDataSource {
    self.dataArray = @[].mutableCopy;
    
    WBTagListModel *model = [WBTagListModel new];
    model.title = @"骑士队";
    
    WBTagListModel *model1 = [WBTagListModel new];
    model1.title = @"金州勇士队";
    
    WBTagListModel *model2 = [WBTagListModel new];
    model2.title = @"休斯顿火箭队";
    
    WBTagListModel *model3 = [WBTagListModel new];
    model3.title = @"热火";
    
    [self.dataArray addObject:model];
    [self.dataArray addObject:model1];
    [self.dataArray addObject:model2];
    [self.dataArray addObject:model3];
    [self.dataArray addObject:model];
    [self.dataArray addObject:model1];
    [self.dataArray addObject:model2];
    [self.dataArray addObject:model3];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark < WBTagListViewCellDelegate >
- (void)wbtagListViewCell:(WBTagListViewCell *)cell selectedItem:(WBTagListItem *)item deselectedItem:(WBTagListItem *)deselectedItem {
    if (item) {
        WBTagListModel *model = self.dataArray[item.itemTag];
        model.isSelected = item.isSelected;
        [self.dataArray replaceObjectAtIndex:item.itemTag withObject:model];
    }
    
    if (deselectedItem) {
        WBTagListModel *model = self.dataArray[deselectedItem.itemTag];
        deselectedItem.isSelected = deselectedItem.isSelected;
        [self.dataArray replaceObjectAtIndex:deselectedItem.itemTag withObject:model];
    }
    NSLog(@"%@",cell.selectedItems);
}

#pragma mark < UITableViewDelegate,UITableViewDataSource >
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBTagListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.items = self.dataArray;
    cell.itemHeight = 35;
    cell.leftRightMargin = 35;
    cell.minimumLineSpacing = 20;
    cell.titleColor = [UIColor orangeColor];
    cell.titleSelectedColor = [UIColor yellowColor];
    cell.borderWidth = 1;
    cell.cornerRadius = 3.f;
    cell.borderColor = [UIColor lightGrayColor];
    cell.selectedBorderColor = [UIColor orangeColor];
    cell.font = [UIFont systemFontOfSize:20.f];
    cell.allowMultipleSelection = YES;
    cell.delegate = self;
    return cell;
}



@end
