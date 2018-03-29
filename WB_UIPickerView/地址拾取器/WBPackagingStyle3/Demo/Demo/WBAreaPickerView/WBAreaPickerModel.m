//
//  WB_AreaPickerModel.m
//  WB_AreaPickerViewDemo1
//
//  Created by Admin on 2017/7/19.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBAreaPickerModel.h"

@implementation WBAreaPickerModel


@end

@implementation WBProvinceModel
- (void)configWithDic:(NSDictionary *)dic {
    
    NSArray *citys = [dic allKeys];
    
    NSMutableArray *tmpCitys = [NSMutableArray arrayWithCapacity:citys.count];
    for (NSString *tmp in citys) {
        WBCityModel *city = [[WBCityModel alloc]init];
        city.name = tmp;
        city.province = self.name;
        NSArray *area = [dic objectForKey:tmp];
        [city configWithArr:area];
        [tmpCitys addObject:city];
    }
    self.cities = [tmpCitys copy];
}

@end

@implementation WBCityModel
- (void)configWithArr:(NSArray *)arr {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSString *tmp in arr) {
        WBAreaModel *area = [[WBAreaModel alloc]init];
        area.name = tmp;
        area.province = self.province;
        area.city = self.name;
        [array addObject:area];
    }
    self.areas = [array copy];
}
@end

@implementation WBAreaModel

@end
