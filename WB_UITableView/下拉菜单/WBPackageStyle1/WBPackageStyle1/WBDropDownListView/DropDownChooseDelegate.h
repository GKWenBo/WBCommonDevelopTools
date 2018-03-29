//
//  DropDownChooseDelegate.h
//  DropDownListView
//
//  Created by WMB on 2016/12/20.
//  Copyright © 2016年 文波. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DropDownChooseDelegate <NSObject>
@optional

- (void)chooseAtSection:(NSInteger)section index:(NSInteger)index;

@end

@protocol DropDownChooseDataSource <NSObject>
/**  多少行  */
- (NSInteger)numberOfSections;
/**  每组有几行  */
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
/**  行标题  */
- (NSString *)titleInSection:(NSInteger)section index:(NSInteger)index;
/**  组标题  */
- (NSString *)defaultTitleInSection:(NSInteger)section; /**< 根据实际情况 看用哪个 , 注意修改 DropDownListView.m initWithFrame 中button设置默认title方法*/

@end
