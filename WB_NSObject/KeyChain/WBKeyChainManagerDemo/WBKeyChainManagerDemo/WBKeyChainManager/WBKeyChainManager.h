//
//  WBKeyChainManager.h
//  WBKeyChainManagerDemo
//
//  Created by WMB on 2018/3/30.
//  Copyright © 2018年 WMB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBKeyChainManager : NSObject

/**
 Save uuid to keychain.

 @param UUID uuid.
 */
+ (void)wb_saveUUID:(NSString *)UUID;

/**
 Read uuid from keychain.

 @return uuid
 */
+ (NSString *)wb_readUUID;
/**
 
 Delete keychain uuid.
 */
+ (void)wb_deleteUUID;

@end
