//
//  WBPublishPopContainerView.h
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WBPublishPopItem.h"

@class WBPublishPopContainerView;

@protocol WBPublishPopContainerViewDelegate <NSObject>

@optional
- (void)didSelectItemWithCenterView:(WBPublishPopContainerView *)centerView andItem:(WBPublishPopItem *)item;

@end

@protocol WBPublishPopContainerViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsWithCenterView:(WBPublishPopContainerView *)centerView;
- (WBPublishPopItem *)itemWithCenterView:(WBPublishPopContainerView *)centerView item:(NSInteger)item;

@end

@interface WBPublishPopContainerView : UIView


@property (nonatomic, assign) id<WBPublishPopContainerViewDelegate> delegate;
@property (nonatomic, assign) id<WBPublishPopContainerViewDataSource> dataSource;

- (void)dismis;

- (void)reloadData;

@end
