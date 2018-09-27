//
//  ViewController.m
//  APPUpdateVersion
//
//  Created by Mr_Lucky on 2018/7/23.
//  Copyright © 2018年 Dotey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self checkAppVersion];
}

- (void)checkAppVersion {
    
    /*  < 本地获取当前项目版本号 > */
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    /*  < currentVersion为当前工程项目版本号 > */
    NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    /*  < appid > */
    NSString *appid = @"1234567543";
    /*  < 查询地址 > */
    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",appid];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *sessionTask = [urlSession dataTaskWithRequest:request
                  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                      if (!error) {
                          NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                          NSLog(@"%@",dict);
                          NSArray *array = dict[@"results"];
                          NSDictionary *lastDict = array.lastObject;
                          
                          NSString *iTuneVersion = lastDict[@"version"];
                          if ([iTuneVersion isEqualToString:currentVersion]) {
                              NSLog(@"已是最新版本");
                          }else {
                              NSLog(@"可版本更新");
                              
                              UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",iTuneVersion] preferredStyle:UIAlertControllerStyleAlert];
                              UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                  //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下
                                  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", appid]];
                                  [[UIApplication sharedApplication] openURL:url];
                              }];
                              UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                  
                              }];
                              [alercConteoller addAction:actionYes];
                              [alercConteoller addAction:actionNo];
                              [self presentViewController:alercConteoller animated:YES completion:nil];
                          }
                      }
                  }];
    /*  < 开始请求任务 > */
    [sessionTask resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
