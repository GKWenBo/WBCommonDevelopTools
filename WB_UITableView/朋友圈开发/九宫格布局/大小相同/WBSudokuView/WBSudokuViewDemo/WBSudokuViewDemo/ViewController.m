//
//  ViewController.m
//  WBSudokuViewDemo
//
//  Created by WMB on 2017/11/1.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "WBSudokuView.h"
@interface ViewController ()
{
    WBSudokuView *view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view, typically from a nib.
    view = [[WBSudokuView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(15);
        make.height.mas_equalTo(@0);
    }];
    NSArray *array = @[@"1",@"2",@"3",@"3",@"3",@"3",@"3",@"3",@"3"];
    [view setupSudokuView:view dataSource:array completeBlock:^(NSInteger clickedIndex) {
        NSLog(@"%ld",clickedIndex);
    }];
    CGSize size = [WBSudokuView calculateSudokuViewSize:array];
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
