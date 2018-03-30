//
//  WBKeyChainManager.m
//  WBKeyChainManagerDemo
//
//  Created by WMB on 2018/3/30.
//  Copyright © 2018年 WMB. All rights reserved.
//

#import "WBKeyChainManager.h"
#import "WBKeyChain.h"

/** << 字典key > */
static NSString *const kUUID_Key = @"kUUID_Key";
/** << keychain key > */
static NSString *const kUUID_KeyChain_Key = @"kUUID_KeyChain_Key";

@implementation WBKeyChainManager

+ (void)wb_saveUUID:(NSString *)UUID {
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:UUID forKey:kUUID_Key];
    [WBKeyChain saveServer:kUUID_KeyChain_Key data:usernamepasswordKVPairs];
}

+ (NSString *)wb_readUUID {
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[WBKeyChain loadServer:kUUID_KeyChain_Key];
    return [usernamepasswordKVPair objectForKey:kUUID_Key];
}

+ (void)wb_deleteUUID {
    [WBKeyChain deleteServer:kUUID_KeyChain_Key];
}

@end
