//
//  ViewController.m
//  WBLandscapeScrollView
//
//  Created by Admin on 2018/1/16.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
@interface ViewController () <WBLandscapeScrollViewDelegate,WBLandscapeScrollViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomView *view = [[CustomView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
    view.delegate = self;
    view.dataSource = self;
    [self.view addSubview:view];
    
    NSArray *testArray = @[@"1",@"2",@"3",@"4",@"5"];
    [view wb_addDataSourceAndReload:testArray];
    // Do any additional setup after loading the view, typically from a nib
    
}

#pragma mark ------ < WBLandscapeScrollViewDelegate,WBLandscapeScrollViewDataSource > ------
#pragma mark
- (UICollectionViewCell *)wb_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (CGSize)wb_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 180);
}

- (CGFloat)wb_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
