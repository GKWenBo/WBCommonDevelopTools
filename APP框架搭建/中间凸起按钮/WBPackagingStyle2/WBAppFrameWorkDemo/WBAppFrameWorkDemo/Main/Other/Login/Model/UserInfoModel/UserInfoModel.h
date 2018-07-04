//
//  UserInfoModel.h
//  DatapersistenceDemo(归档)
//
//  Created by Admin on 2017/8/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBArchiveBaseModel.h"

@interface UserInfoModel : WBArchiveBaseModel

/**< 自有系统统一加密的用户唯一ID（自动登录使用）, */
@property (nonatomic, strong) NSString *uid;
/**< 自有系统统一加密的用户登录秘钥 （自动登录使用）, */
@property (nonatomic, strong) NSString *access_token;
/**< 用户权限有限性鉴定的值 */
@property (nonatomic, copy) NSString *verify_auth_token;
/** 用户名 */
@property (nonatomic, strong) NSString *nickName;
/** 电话号码 */
@property (nonatomic, strong) NSString *mobile;
/** 生日 */
@property (nonatomic, strong) NSString *birthday;
/** 年龄 */
@property (nonatomic, strong) NSString *age;
/** 头像 */
@property (nonatomic, copy) NSString *avatar;

/** 记录是否登录 */
@property (nonatomic, assign) BOOL isLogin;

#pragma mark -- UserInfo Datapersistence
#pragma mark

/**
 第一次登录时调用
 
 @param userInfo Need save UserInfoModel
 */
+ (void)wb_firstLoginSaveUserInfo:(UserInfoModel *)userInfo;

/**
 修改某个属性 置nil时使用
 
 @param userInfo Need save UserInfoModel
 */
+ (void)wb_saveUserInfo:(UserInfoModel *)userInfo;

/**
 更新时使用
 
 @param userInfo Need save UserInfoModel
 */
+ (void)wb_updateUserInfo:(UserInfoModel *)userInfo;

/**
 获取保存数据
 
 @return userInfo
 */
+ (UserInfoModel *)wb_getUserInfo;

/**
 获取token字符串
 
 @return token字符串
 */
+ (NSString *)getVerify_auth_token;

/**
 更新加密
 
 @param dict 加密数据
 */
+ (void)wb_updateToken:(NSDictionary *)dict;

/**
 退出登录时调用
 */
+ (void)wb_logout;

@end
