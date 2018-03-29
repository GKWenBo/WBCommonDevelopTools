//
//  ViewController.m
//  WB_StarRatingView
//
//  Created by Admin on 2017/7/25.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /** 整颗星星类型 */
    {
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, CGRectGetWidth(self.view.frame), 30)];
        
        scoreLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:scoreLabel];
        
        WBStarRatingView *ratingView = [[WBStarRatingView alloc] initWithFrame:CGRectMake(15, 100, 150, 0)]; //初始化并设置frame和个数

        ratingView.spacing = 10.0f; //间距

        ratingView.rateStyle = WBStarRateWholeStyle; //评分类型
        
        ratingView.touchEnabled = YES; //是否启用点击评分 如果纯为展示则不需要设置
        
        ratingView.slideEnabled = YES; //是否启用滑动评分 如果纯为展示则不需要设置
        
        ratingView.maxLimitScore = 10.0f; //最大分数
        
        ratingView.minLimitScore = 0.0f; //最小分数
        
        [self.view addSubview:ratingView];
        
        // 当前分数变更事件回调
        
        ratingView.scoreBlock = ^(CGFloat score) {
           NSLog(@"一 [%.2f]" , score);
        };
        
        // 请在设置完成最大最小的分数后再设置当前分数 并确保当前分数在最大和最小分数之间
        
//                ratingView.currentScore = 2.3f;
    }
    
    /** 半颗星星类型 */
    {
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, CGRectGetWidth(self.view.frame), 30)];
        
        scoreLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:scoreLabel];
        
        WBStarRatingView *ratingView = [[WBStarRatingView alloc] initWithFrame:CGRectMake(15, 200, 200, 0)];
        
        ratingView.spacing = 10.0f;
        
        ratingView.rateStyle = WBStarRateUnlimitedStyle;
        
        ratingView.touchEnabled = YES;
        
        ratingView.slideEnabled = YES;
        
        ratingView.maxLimitScore = 10.0f;
        
        ratingView.minLimitScore = 0.0f;
        
        [self.view addSubview:ratingView];
        
        ratingView.scoreBlock = ^(CGFloat score) {
            NSLog(@"一 [%.2f]" , score);
        };
        
        // 请在设置完成最大最小的分数后再设置当前分数
        
        ratingView.currentScore = 5.f;
    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
