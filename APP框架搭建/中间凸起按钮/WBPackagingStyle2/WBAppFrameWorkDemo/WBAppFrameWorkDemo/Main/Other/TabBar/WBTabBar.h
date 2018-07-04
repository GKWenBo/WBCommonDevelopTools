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
/**  < 中间按钮点击代理方法 >  */
- (void)wb_tabBarPlusBtnClicked:(WBTabBar *)tabBar selectedIndex:(NSInteger)selectedIndex isPlusBtn:(BOOL)isPlusBtn;
@end

@interface WBTabBar : UITabBar

/**  < 需要特殊处理的按钮 >  */
@property (nonatomic, assign) NSInteger plusBtnIndex;
@property (nonatomic,assign) id<WBTabBarDelegate> myDelegate;
- (void)wb_selectedTabBarItemAtIndex:(NSInteger)selectedIndex;

@end
