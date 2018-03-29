//
//  WBSingleComponentPickerView.m
//  Demo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBSingleComponentPickerView.h"
@interface WBSingleComponentPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString * selectData;
    NSInteger selectRow;
}
@end
@implementation WBSingleComponentPickerView

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    _rowHeight = 40.f;
    _componentWidth = 40.f;
    _unitString = @"";
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
}

#pragma mark -- UIPickerViewDelegate,UIPickerViewDataSource
#pragma mark
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.isNeedUnit ? 3 : 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.isNeedUnit) {
        switch (component) {
            case 0:
                return 1;
                break;
            case 1:
                return self.dataArray.count;
                break;
            case 2:
                return 1;
                break;
            default:
                return 0;
                break;
        }
    }else {
        return self.dataArray.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.rowHeight;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (self.isNeedUnit) {
        switch (component) {
            case 0:
                return (self.width - self.componentWidth) / 2.f;
                break;
            case 1:
                return self.componentWidth;
                break;
            case 2:
                return (self.width - self.componentWidth) / 2.f;
                break;
            default:
                return 0;
                break;
        }
    }else {
        return self.width;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectData = self.dataArray[row];
    selectRow = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    //设置分割线的颜色
    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height <=1) {
            obj.backgroundColor = self.lineColor;
        }
    }];
    if (self.isNeedUnit) {
        switch (component) {
            case 0:
            {
                return nil;
            }
                break;
            case 1:
            {
                UILabel * label = [UILabel new];
                label.font = self.font;
                label.textAlignment = NSTextAlignmentCenter;
                label.text = self.dataArray[row];
                return label;
            }
                break;
            case 2:
            {
                UILabel *label = [[UILabel alloc]init];
                [label setText:self.unitString];
                [label setFont:self.font];
                [label setTextAlignment:NSTextAlignmentLeft];
                return label;
            }
                break;
                
            default:
                return nil;
                break;
        }
    }else {
        UILabel * label = [UILabel new];
        label.font = self.font;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.dataArray[row];
        return label;
    }
}

#pragma mark -- Event Response
#pragma mark
- (void)confirmBtnClicked {
    [super confirmBtnClicked];
    if (_SelectedBlock) {
        _SelectedBlock(selectRow,selectData);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(wb_singleComponentPickerView:row:selectData:)]) {
        [_delegate wb_singleComponentPickerView:self row:selectRow selectData:selectData];
    }
}


#pragma mark -- Setter And Getter
#pragma mark
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    selectData = dataArray.firstObject;
    selectRow = 0;
    [self.pickerView reloadAllComponents];
}

- (void)setUnitString:(NSString *)unitString {
    _unitString = unitString;
    [self.pickerView reloadAllComponents];
}


@end
