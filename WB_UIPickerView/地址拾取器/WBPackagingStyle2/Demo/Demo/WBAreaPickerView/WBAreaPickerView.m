//
//  WBAreaPickerView.m
//  Demo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBAreaPickerView.h"

@interface WBAreaPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>

#pragma mark -- Property
#pragma mark
@property (nonatomic, strong, nullable)NSArray *arrayRoot;
@property (nonatomic, strong, nullable)NSMutableArray *arrayProvince;
@property (nonatomic, strong, nullable)NSMutableArray *arrayCity;
@property (nonatomic, strong, nullable)NSMutableArray *arrayArea;
@property (nonatomic, strong, nullable)NSMutableArray *arraySelected;
@property (nonatomic, strong, nullable)NSString *province;
@property (nonatomic, strong, nullable)NSString *city;
@property (nonatomic, strong, nullable)NSString *area;
@end

@implementation WBAreaPickerView

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    _pickerRowHeight = 40.f;
    [self.arrayRoot enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayProvince addObject:obj[@"state"]];
    }];
    NSMutableArray *citys = [NSMutableArray arrayWithArray:[self.arrayRoot firstObject][@"cities"]];
    [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayCity addObject:obj[@"city"]];
    }];
    self.arrayArea = [citys firstObject][@"area"];
    self.province = self.arrayProvince[0];
    self.city = self.arrayCity[0];
    if (self.arrayArea.count != 0) {
        self.area = self.arrayArea[0];
    }else{
        self.area = @"";
    }
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

#pragma mark -- UIPickerViewDelegate,UIPickerViewDataSource
#pragma mark
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.arrayProvince.count;
    }else if (component == 1) {
        return self.arrayCity.count;
    }else{
        return self.arrayArea.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.pickerRowHeight;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.arraySelected = self.arrayRoot[row][@"cities"];
        
        [self.arrayCity removeAllObjects];
        [self.arraySelected enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.arrayCity addObject:obj[@"city"]];
        }];
        
        self.arrayArea = [NSMutableArray arrayWithArray:[self.arraySelected firstObject][@"areas"]];
        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }else if (component == 1) {
        if (self.arraySelected.count == 0) {
            self.arraySelected = [self.arrayRoot firstObject][@"cities"];
        }
        
        self.arrayArea = [NSMutableArray arrayWithArray:[self.arraySelected objectAtIndex:row][@"areas"]];
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }else{
    }
    
    [self reloadData];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    //设置分割线的颜色
    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height <=1) {
            obj.backgroundColor = self.lineColor;
        }
    }];
    NSString *text;
    if (component == 0) {
        text =  self.arrayProvince[row];
    }else if (component == 1){
        text =  self.arrayCity[row];
    }else{
        if (self.arrayArea.count > 0) {
            text = self.arrayArea[row];
        }else{
            text =  @"";
        }
    }
    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
}

#pragma mark -- Private Method
#pragma mark
- (void)reloadData
{
    NSInteger index0 = [self.pickerView selectedRowInComponent:0];
    NSInteger index1 = [self.pickerView selectedRowInComponent:1];
    NSInteger index2 = [self.pickerView selectedRowInComponent:2];
    self.province = self.arrayProvince[index0];
    self.city = self.arrayCity[index1];
    if (self.arrayArea.count != 0) {
        self.area = self.arrayArea[index2];
    }else{
        self.area = @"";
    }
}

#pragma mark -- Events Response
#pragma mark
- (void)confirmBtnClicked {
    [self dismiss];
    if (_AreaSelectedBlock) {
        _AreaSelectedBlock(self.province,self.city,self.area);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(pickerArea:province:city:area:)]) {
        [_delegate pickerArea:self province:self.province city:self.city area:self.area];
    }
}

#pragma mark -- Getter And Setter
#pragma mark
- (NSArray *)arrayRoot
{
    if (!_arrayRoot) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        _arrayRoot = [[NSArray alloc]initWithContentsOfFile:path];
    }
    return _arrayRoot;
}

- (NSMutableArray *)arrayProvince
{
    if (!_arrayProvince) {
        _arrayProvince = @[].mutableCopy;
    }
    return _arrayProvince;
}

- (NSMutableArray *)arrayCity
{
    if (!_arrayCity) {
        _arrayCity = @[].mutableCopy;
    }
    return _arrayCity;
}

- (NSMutableArray *)arrayArea
{
    if (!_arrayArea) {
        _arrayArea = @[].mutableCopy;
    }
    return _arrayArea;
}

- (NSMutableArray *)arraySelected
{
    if (!_arraySelected) {
        _arraySelected = @[].mutableCopy;
    }
    return _arraySelected;
}

@end
