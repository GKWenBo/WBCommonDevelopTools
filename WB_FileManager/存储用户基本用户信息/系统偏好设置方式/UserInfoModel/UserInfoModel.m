//
//  UserInfoModel.m
//  DataPersistenceDemo
//
//  Created by Admin on 2017/8/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "UserInfoModel.h"
static NSString *const kUserInfoDatapersistenceKey = @"kUserInfoDatapersistenceKey";
@implementation UserInfoModel

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"gender" : @[@"gender",@"sex"]};
//}

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"tag": [LXUserTagModel class]};
//}
#pragma mark -- UserInfo Datapersistence
#pragma mark

/**
 第一次登录时调用
 
 @param userInfo Need save UserInfoModel
 */
+ (void)wb_firstLoginSaveUserInfo:(UserInfoModel *)userInfo {
    userInfo.isLogin = YES;
    [self wb_saveUserInfo:userInfo];
}

/**
 修改某个属性 置nil时使用
 
 @param userInfo Need save UserInfoModel
 */
+ (void)wb_saveUserInfo:(UserInfoModel *)userInfo {
    NSDictionary *dict = [userInfo yy_modelToJSONObject];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dict forKey:kUserInfoDatapersistenceKey];
    BOOL ret = [userDefaults synchronize];
    NSLog(ret ? @"用户信息保存成功" : @"用户信息保存失败");
}

/**
 更新时使用
 
 @param userInfo Need save UserInfoModel
 */
+ (void)wb_updateUserInfo:(UserInfoModel *)userInfo {
    UserInfoModel *tempModel = [self wb_getUserInfo];
    if (userInfo) {
        userInfo.isLogin = tempModel.isLogin;
        userInfo.verify_auth_token = tempModel.verify_auth_token;
        userInfo.uid = tempModel.uid;
        userInfo.access_token = tempModel.access_token;
    }
    NSDictionary *dict = [userInfo yy_modelToJSONObject];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dict forKey:kUserInfoDatapersistenceKey];
    BOOL ret = [userDefaults synchronize];
    NSLog(ret ? @"用户信息更新成功" : @"用户信息更新失败");
}

/**
 获取保存数据
 
 @return userInfo
 */
+ (UserInfoModel *)wb_getUserInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefaults objectForKey:kUserInfoDatapersistenceKey];
    return [UserInfoModel yy_modelWithJSON:dict];
}

/**
 获取token字符串
 
 @return token字符串
 */
+ (NSString *)getVerify_auth_token {
    return [self wb_getUserInfo].verify_auth_token;
}

/**
 更新加密
 
 @param dict 加密数据
 */
+ (void)wb_updateToken:(NSDictionary *)dict {
    UserInfoModel *userInfo = [UserInfoModel wb_getUserInfo];
    userInfo.uid = dict[@"uid"];
    userInfo.access_token = dict[@"access_token"];
    userInfo.verify_auth_token = dict[@"verify_auth_token"];
    [UserInfoModel wb_saveUserInfo:userInfo];
}

+ (void)wb_logout {
    [self wb_saveUserInfo:nil];
}

@end
