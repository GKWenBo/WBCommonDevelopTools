//
//  ViewController.m
//  WB_StarRatingView
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "WBStarRatingView.h"
@interface ViewController () <WB_StarRatingViewDelegate>
@property (weak, nonatomic) IBOutlet WBStarRatingView *starView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _starView.delegate = self;
    [_starView setScore:0.5 isAnimated:YES];
}

- (void)wb_starRatingView:(WBStarRatingView *)wb_starRatingView score:(CGFloat)score {
    NSLog(@"%f",score);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
