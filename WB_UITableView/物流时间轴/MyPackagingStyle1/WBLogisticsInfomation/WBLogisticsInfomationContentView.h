//
//  WB_LogisticsInfomationContentView.h
//  WB_LogisticsInfomationDemo
//
//  Created by Admin on 2017/7/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBLogisticsInfomationModel.h"
@interface WBLogisticsInfomationContentView : UIView
@property (nonatomic, assign) BOOL hasUpLine;
@property (nonatomic, assign) BOOL hasDownLine;
@property (nonatomic, assign) BOOL currented;/** 最新信息 */

@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *dateLabel;

- (void)reloadDataWithModel:(WBLogisticsInfomationModel *)model;
@end
