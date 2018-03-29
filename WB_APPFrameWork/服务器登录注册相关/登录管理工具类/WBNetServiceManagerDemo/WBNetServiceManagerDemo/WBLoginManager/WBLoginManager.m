//
//  WBLoginManager.m
//  WBNetServiceManagerDemo
//
//  Created by WMB on 2017/9/25.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBLoginManager.h"
static WBLoginManager *manager = nil;
@implementation WBLoginManager
+ (instancetype)shareManager {
    if (!manager) {
        manager = [WBLoginManager alloc]init;
    }
    return manager;
}
@end
