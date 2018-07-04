//
//  WBBasePublicViewController.h
//  WBAppFrameWorkDemo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBBasePublicViewController : UIViewController

/**
 设置导航栏返回按钮
 */
- (void)wb_setNavigationBackButton;

/**
 BackButton Event

 @param sender BackButton
 */
- (void)wb_navigationButtonClicked:(UIButton *)sender;

/**
 Reset backButton image

 @param imageName ImageName
 */
- (void)wb_resetNavigationButtonImage:(NSString *)imageName;

/**
 Initialize datasource
 */
- (void)initializeDataSource;

/**
 Initialize userInterface
 */
- (void)initializeUserInterface;

/**
 Load data
 */
- (void)wb_loadData;
/**
 Pull up to load more data
 */
- (void)wb_loadMoreData;

/**
 添加下拉刷新

 @param scrollView 滚动视图
 */
- (void)wb_addScrollViewHeaderRefresh:(id)scrollView;

/**
 添加上下拉刷新

 @param scrollView 滚动视图
 */
- (void)wb_addScrollViewHeaderFooterRefresh:(id)scrollView;

@end
