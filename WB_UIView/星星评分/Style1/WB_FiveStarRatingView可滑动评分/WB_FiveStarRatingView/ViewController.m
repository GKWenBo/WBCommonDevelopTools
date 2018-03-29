//
//  ViewController.m
//  WB_FiveStarRatingView
//
//  Created by Admin on 2017/7/20.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "WBStarView.h"
#import "WBFiveStarRatingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WBFiveStarRatingView * view = [[WBFiveStarRatingView alloc]
                                    initWithFrame:CGRectMake(50, 150, 150, 30)];
    view.backgroundColor = [UIColor cyanColor];
    view.scoreNum = @5;
    view.normalColorChain([UIColor grayColor]);
    view.highlightColorChian([UIColor orangeColor]);
    view.scroreBlock = ^(NSNumber *scoreNumber) {
        NSLog(@"分数为：%@",scoreNumber);
    };

    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
