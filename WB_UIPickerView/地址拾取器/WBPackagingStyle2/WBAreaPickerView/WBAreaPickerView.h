//
//  WBAreaPickerView.h
//  Demo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBBasePickerView.h"
@class WBAreaPickerView;
@protocol WBAreaPickerViewDelegate <NSObject>
@optional;
- (void)pickerArea:(WBAreaPickerView *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area;
@end
@interface WBAreaPickerView : WBBasePickerView
/** 行高度 默认40 */
@property (nonatomic, assign) CGFloat pickerRowHeight;
/** 代理属性 */
@property (nonatomic, assign) id<WBAreaPickerViewDelegate> delegate;
/** 地址选择回调 */
@property (nonatomic,copy) void(^AreaSelectedBlock)(NSString *province,NSString *city,NSString *area);
@end
