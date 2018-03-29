//
//  WB_AreaPickerModel.h
//  WB_AreaPickerViewDemo1
//
//  Created by Admin on 2017/7/19.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAreaPickerModel : NSObject

@property (nonatomic, strong) NSString *name;
@end

@interface WBProvinceModel : WBAreaPickerModel

@property (nonatomic, strong) NSArray *cities;
- (void)configWithDic:(NSDictionary *)dic;
@end

@interface WBCityModel : WBAreaPickerModel

@property (nonatomic, copy) NSString *province;
@property (nonatomic, strong) NSArray *areas;
- (void)configWithArr:(NSArray *)arr;
@end

@interface WBAreaModel : WBAreaPickerModel

@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@end
