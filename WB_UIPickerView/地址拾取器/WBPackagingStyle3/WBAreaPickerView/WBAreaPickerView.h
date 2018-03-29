//
//  WB_AreaPickerView.h
//  WB_AreaPickerViewDemo1
//
//  Created by Admin on 2017/7/19.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBBasePickerView.h"
typedef void(^AreaSelectedBlock)(NSString *province,NSString *city,NSString *area);
@interface WBAreaPickerView : WBBasePickerView
/** 行高度 默认：40.f */
@property (nonatomic, assign) CGFloat pickerRowHeight;
/** 地址选择回调 */
@property (nonatomic,copy) AreaSelectedBlock selectedArea;
@end
