//
//  WB_AddressPickerView.h
//  WB_AddressPickerView
//
//  Created by Admin on 2017/7/28.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AdressBlock)(NSString *province,NSString *city,NSString *area);

@interface WBAddressPickerView : UIView

@property (nonatomic,copy) AdressBlock block;

/**
 绑定默认值 省名 市名 区名

 @param province 省
 @param cityName 市名
 @param areaName 区名
 */
- (void)configDataProvince:(NSString *)province cityName:(NSString *)
cityName areaName:(NSString *)areaName;

/**
 弹出地址选择视图
 */
- (void)show;

/**
 隐藏地址选择视图
 */
- (void)dismiss;

@end
