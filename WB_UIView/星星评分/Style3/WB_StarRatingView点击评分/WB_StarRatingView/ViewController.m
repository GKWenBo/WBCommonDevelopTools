//
//  ViewController.m
//  WB_StarRatingView
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "WBStarRatingView.h"
@interface ViewController ()
{
    WBStarRatingView *starRatingView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    starRatingView = [[WBStarRatingView alloc]initWithFrame:CGRectMake(0, 0, 200, 40) numberOfStars:5];
    starRatingView.style = WBStarRateIncompleteStyle;
    starRatingView.currentScore = 1.5;
    starRatingView.hasAnimation = YES;
    starRatingView.center = self.view.center;
    starRatingView.scoreChangeBlock = ^(CGFloat score) {
        NSLog(@"%f",score);
    };
    [self.view addSubview:starRatingView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


@end
