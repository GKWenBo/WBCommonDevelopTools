//
//  ViewController.m
//  WB_PhotoBrowser
//
//  Created by Admin on 2017/7/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "WBPhotoBrowserManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taped)];
    _imageView1.userInteractionEnabled = YES;
//    [_imageView1 addGestureRecognizer:tap];
    [_imageVIew2 addGestureRecognizer:tap];
}

- (void)taped {
//    [[WB_PhotoBrowserManager shareManager] showLocalPhotoBrowser:@[_imageView1,_imageVIew2] selectedImageIndex:1];
    [[WBPhotoBrowserManager shareManager] showNetWorkPhotoBrowserWithOriginImageViews:@[_imageVIew2] urlStrArr:@[@"http://img.yiank.cn/group1/M00/00/02/drL8AlkBhsGAMid-AABHWDYXwvs111.png"] selectedImageIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
