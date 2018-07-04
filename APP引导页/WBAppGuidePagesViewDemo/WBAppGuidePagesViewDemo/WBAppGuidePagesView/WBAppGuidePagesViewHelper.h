//
//  WBAppGuidePagesViewHelper.h
//  WBAppGuidePagesViewDemo
//
//  Created by wenbo on 2018/5/14.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAppGuidePagesViewHelper : NSObject

/**
 单例管理类

 @return instance WBAppGuidePagesViewHelper.
 */
+ (instancetype)shareHelper;

/**
 Show guide pages view.

 @param images images array.
 */
- (void)wb_showGuidePagesViewWithDataArray:(NSArray <NSString *>*)images;

@end
