//
//  WB_IndicatorView.h
//  DaShenLianMeng
//
//  Created by Admin on 2017/9/8.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBIndicatorView : UIView

- (void)settingDefault;

//* 小点的个数，最小为12否则无效；转动速度，大于0；背景颜色；小点的背景颜色；小点的大小，0-1;运动半径，0-1*/
- (void)num:(int)num speed:(float)speed backGroundColor:(UIColor *)backColor color:(UIColor *)color moveViewSize:(float)moveViewSize moveSize:(float)moveSize;

- (void)startAnimating;
- (void)stopAnimating;

@end
