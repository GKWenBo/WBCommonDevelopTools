//
//  WB_ShoppingCartCountView.h
//  WB_ShoppingCartCountView
//
//  Created by WMB on 2017/6/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBShoppingCartCountView : UIView

/**  分割线颜色  默认浅灰色  */
@property (nonatomic,strong) UIColor * lineColor;

@property (nonatomic,strong) NSString * currentCount;

/**  最大数量 默认为5  */
@property (nonatomic,strong) NSString * maxCount;

/**  文本框改变后回调  */
@property (nonatomic,copy) void (^CurrentCountBlock) (NSString * count);


@end
