//
//  WB_AreaPickerView.m
//  WB_AreaPickerViewDemo1
//
//  Created by Admin on 2017/7/19.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBAreaPickerView.h"
#import "WBAreaPickerModel.h"
@interface WBAreaPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    WBProvinceModel * currentProvince;
    WBCityModel * currentCity;
    WBAreaModel * currentArea;
}
@property (strong, nonatomic) NSMutableArray *dataSource;
@end
@implementation WBAreaPickerView

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    _pickerRowHeight = 40;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self loadLocalData];
}

#pragma mark -- 加载数据源
#pragma mark
- (void)loadLocalData {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *provinces = [dic allKeys];
    for (NSString *tmp in provinces) {
        WBProvinceModel * provinceModel = [[WBProvinceModel alloc]init];
        provinceModel.name = tmp;
        NSArray * arr = [dic objectForKey:tmp];
        NSDictionary * cityDic = [arr firstObject];
        [provinceModel configWithDic:cityDic];
        [self.dataSource addObject:provinceModel];
    }
    /** 设置当前数据 */
    WBProvinceModel * defPro = [self.dataSource firstObject];
    currentProvince = defPro;
    WBCityModel * defCity = [defPro.cities firstObject];
    currentCity = defCity;
    currentArea = [defCity.areas firstObject];
}

#pragma mark -- UIPickerViewDelegate,UIPickerViewDataSource
#pragma mark
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.pickerRowHeight;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.dataSource.count;
    }else if (component == 1) {
        return currentProvince.cities.count;
    }else {
        return currentCity.areas.count;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    //设置分割线的颜色
    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height <=1) {
            obj.backgroundColor = self.lineColor;
        }
    }];
    UILabel * customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [UILabel new];
        customLabel.font = [UIFont systemFontOfSize:17.f];
        customLabel.textAlignment = NSTextAlignmentCenter;
    }
    NSString * title = @"";
    if (component == 0) {
        WBProvinceModel * pro = [self.dataSource objectAtIndex:row];
        title = pro.name;
    }else if (component == 1) {
        if (currentProvince.cities.count > row) {
            WBCityModel * city = [currentProvince.cities objectAtIndex:row];
            title = city.name;
        }
    }else {
        if (currentCity.areas.count > row) {
            WBAreaModel * area = [currentCity.areas objectAtIndex:row];
            title = area.name;
        }
    }
    customLabel.text = title;
    return customLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        WBProvinceModel * province = [self.dataSource objectAtIndex:row];
        currentProvince = province;
        WBCityModel * city = [province.cities firstObject];
        currentCity = city;
        currentArea = [city.areas firstObject];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else if (component == 1) {
        if (currentProvince.cities.count > row) {
            WBCityModel * city = [currentProvince.cities objectAtIndex:row];
            currentCity = city;
            currentArea = [city.areas firstObject];
        }
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else if (component == 2) {
        if (currentCity.areas.count > row) {
            currentArea = [currentCity.areas objectAtIndex:row];
        }
    }
}

#pragma mark -- Event Response
#pragma mark
- (void)confirmBtnClicked {
    [self dismiss];
    if (_selectedArea) {
        _selectedArea(currentArea.province,currentArea.city,currentArea.name);
    }
}

#pragma mark -- getter and setter
#pragma mark
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}
@end
