//
//  WBSingleComponentPickerView.h
//  Demo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBBasePickerView.h"
@class WBSingleComponentPickerView;
@protocol WBSingleComponentPickerViewDelegate <NSObject>

@optional
- (void)wb_singleComponentPickerView:(WBSingleComponentPickerView *)wb_singleComponentPickerView row:(NSInteger)row selectData:(NSString *)selectData;

@end
@interface WBSingleComponentPickerView : WBBasePickerView
/** 数据源 */
@property (nonatomic, strong) NSArray<NSString *> *dataArray;
@property (nonatomic,copy) void (^SelectedBlock)(NSInteger row,NSString * selectData);
@property (nonatomic, assign) id<WBSingleComponentPickerViewDelegate> delegate;
/** 是否显示单位 */
@property (nonatomic, assign) BOOL isNeedUnit;
@property (nonatomic, strong) NSString *unitString;
/** 行高度 默认40.f */
@property (nonatomic, assign) CGFloat rowHeight;
/** 组宽度 显示单位时有效 默认40.f */
@property (nonatomic, assign) CGFloat componentWidth;
@end
