//
//  WBLoginManager.h
//  WBNetServiceManagerDemo
//
//  Created by WMB on 2017/9/25.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWBLOGINMANAGER [WBLoginManager shareManager]

@interface WBLoginManager : NSObject
/**
 管理类

 @return WBLoginManager
 */
+ (instancetype)shareManager;

@end
