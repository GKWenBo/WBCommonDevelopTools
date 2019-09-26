//
//  ViewController.m
//  Example1
//
//  Created by WenBo on 2019/9/23.
//  Copyright © 2019 wenbo. All rights reserved.
//

#import "ViewController.h"
#import "SnakePageControl.h"

@interface ViewController ()

@property (nonatomic, strong) SnakePageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    SnakePageControl *pageControl = [SnakePageControl new];
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    pageControl.pageCount = 5;
    pageControl.progress = 2;
    [self.view addSubview:pageControl];
    
    [pageControl.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [pageControl.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
    
    self.pageControl = pageControl;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSInteger newIndex = arc4random_uniform(5);
    self.pageControl.progress = newIndex;
}


@end
