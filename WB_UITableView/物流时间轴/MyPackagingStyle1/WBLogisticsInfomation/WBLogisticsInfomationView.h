//
//  WB_LogisticsInfomationView.h
//  WB_LogisticsInfomationDemo
//
//  Created by Admin on 2017/7/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBLogisticsInfomationView : UIView
@property (nonatomic, strong) NSArray *dataSource;

- (instancetype)initWithDataArray:(NSArray *)array;
- (void)reloadWithDataArray:(NSArray *)dataArrray;
@end
