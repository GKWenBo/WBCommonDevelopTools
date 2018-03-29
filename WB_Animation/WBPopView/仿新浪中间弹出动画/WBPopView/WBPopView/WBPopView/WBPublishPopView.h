//
//  WBPopView.h
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBPublishPopItem.h"

typedef void(^WBDidSelectedBlock)(WBPublishPopItem *item);

@interface WBPublishPopView : UIView

/**
 显示一个popView在某个view上

 @param view 父视图
 @param imageArray 图标数组
 @param titles 标题数组
 @param block 点击回调
 @return return value description
 */
+ (instancetype)wb_showToView:(UIView *)view
                    andImages:(NSArray *)imageArray
                    andTitles:(NSArray *)titles
               andSelectBlock:(WBDidSelectedBlock)block;

@end
