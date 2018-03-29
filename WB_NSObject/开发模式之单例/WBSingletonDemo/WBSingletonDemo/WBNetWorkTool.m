//
//  WBNetWorkTool.m
//  WBSingletonDemo
//
//  Created by WMB on 2017/10/30.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBNetWorkTool.h"
static WBNetWorkTool *instance = nil;
@implementation WBNetWorkTool
///** << 法1 > */
//+ (instancetype)shareTool {
//    static WBNetWorkTool *instance = nil;
//    @synchronized(self) {
//        if (!instance) {
//            instance = [[self alloc]init];
//        }
//    }
//    return instance;
//}

+ (instancetype)shareTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[self alloc]init];
        }
    });
    return instance;
}

@end
