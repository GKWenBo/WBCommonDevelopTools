//
//  APPAPIConst.h
//  Start
//
//  Created by Mr_Lucky on 2018/7/24.
//  Copyright © 2018年 jmw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APPAPIConst : NSObject

// MARK:友盟
UIKIT_EXTERN NSString *const kAPIUMSDKAppKey;
UIKIT_EXTERN NSString *const kAPIUMSDKChannel;
UIKIT_EXTERN NSString *const kAPIUMSDKSocialAppKey;
UIKIT_EXTERN NSString *const kAPIUMSDKMessageStartWithAppKey;
UIKIT_EXTERN NSString *const kAPIUMSDKMessageAppMasterSecret;

/*  < 微信 > */
UIKIT_EXTERN NSString *const kAPIWeChatSDKAppId;
UIKIT_EXTERN NSString *const kAPIWeChatSDKAppSecret;
UIKIT_EXTERN NSString *const kAPIWeChatSDKRedirectURL;

/*  < QQ > */
UIKIT_EXTERN NSString *const kAPIQQSDKAppId;
UIKIT_EXTERN NSString *const kAPIQQSDKAppKey;
UIKIT_EXTERN NSString *const kAPIQQSDKRedirectURL;

/*  < 新浪 > */
UIKIT_EXTERN NSString *const kAPISinaSDKAppKey;
UIKIT_EXTERN NSString *const kAPISinaSDKAppSecret;
UIKIT_EXTERN NSString *const kAPISinaSDKRedirectURL;

/*  < 百度地图 > */
UIKIT_EXTERN NSString *const kAPIBaiduMapSDKKey;

/*  < 神策 > */
UIKIT_EXTERN NSString *const kAPISAServerURL;   //数据接收的 URL

/*  < JPUSH > */
UIKIT_EXTERN NSString *const kAPIJPUSHSDKAppKey;
UIKIT_EXTERN NSString *const kAPIJPUSHSDKChannel;

/*  < 美洽 > */
UIKIT_EXTERN NSString *const kAPIMeiQiaSDKAppKey;

@end
