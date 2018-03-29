//
//  ViewController.m
//  WB_TagsView
//
//  Created by WMB on 2017/9/10.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "ViewController.h"
#import "WBTagsView.h"
@interface ViewController () <WB_TagsViewDelegate>
{
    
    __weak IBOutlet WBTagsView *tagsView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tagsView.borderNormalColor = [UIColor orangeColor];
    tagsView.tagTitleColor = [UIColor redColor];
    tagsView.borderSelectedColor = [UIColor blackColor];
    tagsView.borderWidth = 1.f;
    tagsView.cornerRadius = 4.f;
    tagsView.allowSelected = YES;
    
    tagsView.allMultipleSelected = YES;
//    tagsView.contentInset = UIEdgeInsetsMake(10, 15, 10, 15);
//    tagsView.tagsColumn = 2;
    tagsView.tagsArray = @[@"测试测试测试",@"测试测试测试测试",@"测试",@"测试1",@"测试",@"测试测试测试",@"1"];
    tagsView.allowDefalutSelected = YES;
//    tagsView.defualtSelectedTitleArray = @[@"测试",@"测试",@"测试",@"测试1",@"测试",@"测试",@"1"];
//    tagsView.defaultSelectedIndexArray = @[@(0),@(1)];
    
    tagsView.delegate = self;
    
}
#pragma mark --------  WB_TagsViewDelegate  --------
#pragma mark
- (void)wb_tagsView:(WBTagsView *)wb_tagsView didDeselectedIndex:(NSInteger)index {
    NSLog(@"取消选中%ld",(long)index);
}

- (void)wb_tagsView:(WBTagsView *)wb_tagsView didSelectedIndex:(NSInteger)index {
    NSLog(@"选中%ld",(long)index);
    
}
- (IBAction)test:(id)sender {
    NSLog(@"%@",tagsView.didSelectedTags);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
