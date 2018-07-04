//
//  WBTabBar.h
//  WBAppFrameWorkDemo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBTabBar;

@protocol WBTabBarDelegate <NSObject>
/**  < 中间按钮点击代理方法 >  */
- (void)tabBarPlusBtnClicked:(WBTabBar *)tabBar plusBtn:(UIButton *)plusBtn;
@end

@interface WBTabBar : UITabBar

@property (nonatomic,assign) id<WBTabBarDelegate> myDelegate;

@end
