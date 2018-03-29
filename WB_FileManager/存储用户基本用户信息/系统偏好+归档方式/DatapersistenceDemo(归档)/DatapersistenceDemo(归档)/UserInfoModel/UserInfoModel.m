//
//  UserInfoModel.m
//  DatapersistenceDemo(归档)
//
//  Created by Admin on 2017/8/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "UserInfoModel.h"

static NSString *const kUserInfoDatapersistenceKey = @"kUserInfoDatapersistenceKey";

@implementation UserInfoModel

#pragma mark -- UserInfo Datapersistence
#pragma mark
+ (void)wb_firstLoginSaveUserInfo:(UserInfoModel *)userInfo {
    userInfo.isLogin = YES;
    [self wb_saveUserInfo:userInfo];
}

+ (void)wb_saveUserInfo:(UserInfoModel *)userInfo {
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userData forKey:kUserInfoDatapersistenceKey];
    BOOL ret = [userDefaults synchronize];
    NSLog(ret ? @"用户信息保存成功" : @"用户信息保存失败");
}

+ (void)wb_updateUserInfo:(UserInfoModel *)userInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefaults objectForKey:kUserInfoDatapersistenceKey];
    UserInfoModel *tempModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (tempModel) {
        userInfo.isLogin = tempModel.isLogin;
        userInfo.verify_auth_token = tempModel.verify_auth_token;
        userInfo.uid = tempModel.uid;
        userInfo.access_token = tempModel.access_token;
    }
    /** 更新保存 */
    NSData *userUpdateData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [userDefaults setObject:userUpdateData forKey:kUserInfoDatapersistenceKey];
}

+ (UserInfoModel *)wb_getUserInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefaults objectForKey:kUserInfoDatapersistenceKey];
    return [NSKeyedUnarchiver unarchiveObjectWithData:userData];
}

+ (NSString *)getVerify_auth_token {
    return [self wb_getUserInfo].verify_auth_token;
}

+ (void)wb_updateToken:(NSDictionary *)dict {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefaults objectForKey:kUserInfoDatapersistenceKey];
    UserInfoModel *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    userInfo.uid = dict[@"uid"];
    userInfo.access_token = dict[@"access_token"];
    userInfo.verify_auth_token = dict[@"verify_auth_token"];
    [self wb_saveUserInfo:userInfo];
}

+ (void)wb_logout {
    [self wb_saveUserInfo:nil];
}

@end
