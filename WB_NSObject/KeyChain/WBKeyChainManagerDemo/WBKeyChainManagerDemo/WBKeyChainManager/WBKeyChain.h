//
//  WBKeyChain.h
//  WBKeyChainManagerDemo
//
//  Created by WMB on 2018/3/30.
//  Copyright © 2018年 WMB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
+ (void)saveServer:(NSString *)service data:(id)data;
+ (id)loadServer:(NSString *)service;
+ (void)deleteServer:(NSString *)service;

@end
