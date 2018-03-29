//
//  ViewController.m
//  WB_LogisticsInfomationDemo
//
//  Created by Admin on 2017/7/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "WBLogisticsInfomationView.h"
#import "WBLogisticsInfomationModel.h"
#import "WBLogisticsInfomationConfig.h"
@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *arr = @[@"北包裹正在等待揽收",@"[太原市]百世快递 阳曲收件员 已揽件",@"[太原市]阳曲 已发出",@"[太原市]快件已到达 太原转运中心",@"[太原市]太原转运中心 已发出",@"到济南市【济南转运中心】",@"[济南市]快件已到达 济南转运中心",@"[济南市]济南转运中心 已发出",@"[济南市]【已签收，签收人是拍照签收】，感谢使用百世快递，期待再次为您服务"];
    
    NSArray *dateArray=@[@"2015-6-5",@"2015-6-6",@"2015-6-7",@"2015-6-8",@"2015-6-9",@"2015-6-10",@"2015-6-11",@"2015-6-12",@"2015-6-13"];
    
    for (NSInteger i =arr.count-1; i>=0 ; i--) {
        WBLogisticsInfomationModel *model = [[WBLogisticsInfomationModel alloc]init];
        
        
        model.dsc = [arr objectAtIndex:i];
        
        model.date = [dateArray objectAtIndex:i];
        [self.dataArray addObject:model];
        
        
        
    }
    
    WBLogisticsInfomationView *logis = [[WBLogisticsInfomationView alloc]initWithDataArray:self.dataArray];
    
    logis.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    [self.view addSubview:logis];

}


- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
