//
//  WB_LogisticsInfomationCell.h
//  WB_LogisticsInfomationDemo
//
//  Created by Admin on 2017/7/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBLogisticsInfomationContentView.h"
@class WBLogisticsInfomationModel;
@interface WBLogisticsInfomationCell : UITableViewCell

@property (assign, nonatomic) BOOL hasUpLine;
@property (assign, nonatomic) BOOL hasDownLine;
@property (assign, nonatomic) BOOL currented;
@property (nonatomic, strong) WBLogisticsInfomationContentView *logisticsView;

- (void)configData:(WBLogisticsInfomationModel *)model;
@end
