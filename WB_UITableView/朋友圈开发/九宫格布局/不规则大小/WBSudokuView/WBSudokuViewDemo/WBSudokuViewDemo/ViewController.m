//
//  ViewController.m
//  WBSudokuViewDemo
//
//  Created by Admin on 2017/11/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "WBSudokuView.h"
@interface ViewController ()
{
    WBSudokuView *sudokuView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    sudokuView = [[WBSudokuView alloc]init];
    sudokuView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:sudokuView];
    [sudokuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kSudokuView_LeftMargin);
//        make.right.equalTo(self.view.mas_right).offset(-kSudokuView_RightMargin);
        make.top.equalTo(self.view.mas_top).offset(200);
        make.height.mas_equalTo(@0);
    }];
    NSArray *imageArray = @[@"pic0.jpg",@"pic0.jpg",@"pic0.jpg",@"pic0.jpg"];
    CGSize size = [sudokuView calculateSize:imageArray];
    sudokuView.dataArray = imageArray;
    [sudokuView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
