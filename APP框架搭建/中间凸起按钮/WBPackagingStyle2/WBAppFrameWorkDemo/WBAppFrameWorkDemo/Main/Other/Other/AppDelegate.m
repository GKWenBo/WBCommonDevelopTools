//
//  AppDelegate.m
//  WBAppFrameWorkDemo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "AppDelegate.h"
#import "WBTabBarController.h"
#import "WBLoginViewController.h"
#import "WBBaseNavigationController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self wb_applicationDefaultConfig];
    [self wb_enterGuideIfNeeded];
    
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark ------ < Private Method > ------
#pragma mark
- (void)wb_applicationDefaultConfig {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)wb_enterLoginVcIfNeeded {
    if (![UserInfoModel wb_getUserInfo].isLogin) {
        [self wb_enterMainVc];
    }else {
        [self wb_enterLoginVc];
    }
}

static NSString *const kVersionKey = @"version";
- (BOOL)needGuide {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![[userDefaults objectForKey:kVersionKey] isEqualToString:version]) {
        [userDefaults setObject:version forKey:kVersionKey];
        [userDefaults synchronize];
        return YES;;
    }
    return NO;
}
- (void)wb_enterGuideIfNeeded {
    if ([self needGuide]) {
        [self wb_enterGuideIfNeeded];
    }else {
        [self wb_enterLoginVcIfNeeded];
    }
}

#pragma mark ------ < Public Method > ------
#pragma mark
- (void)wb_enterLoginVc {
    WBLoginViewController *loginVc = [[WBLoginViewController alloc]init];
    WBBaseNavigationController *nav = [[WBBaseNavigationController alloc]initWithRootViewController:loginVc];
    self.window.rootViewController = nav;
}

- (void)wb_enterMainVc {
    WBTabBarController *tabVc = [[WBTabBarController alloc]init];
    self.window.rootViewController = tabVc;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
