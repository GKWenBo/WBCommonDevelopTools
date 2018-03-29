//
//  WBLandscapeScrollView.m
//  WBLandscapeScrollView
//
//  Created by Admin on 2018/1/16.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import "WBLandscapeScrollView.h"

@interface WBLandscapeScrollView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation WBLandscapeScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark ------ < 初始化 > ------
#pragma mark
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark ------ < 设置UI > ------
#pragma mark
- (void)setupUI {
    [self addSubview:self.collectionView];
    [self wb_registerCustomCell];
}

#pragma mark ------ < Publick Method > ------
#pragma mark
- (void)wb_addDataSourceAndReload:(NSArray *)array {
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    [self.collectionView reloadData];
}

- (void)wb_registerCustomCell {
    
}

#pragma mark ------ < UICollectionViewDataSource > ------
#pragma mark
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataSource && [_dataSource respondsToSelector:@selector(wb_collectionView:cellForItemAtIndexPath:)]) {
        return [_dataSource wb_collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    return nil;
}

#pragma mark ------ < UICollectionViewDelegate > ------
#pragma mark
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(wb_collectionView:didSelectItemAtIndexPath:)]) {
        [_delegate wb_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark ------ < UICollectionViewDelegateFlowLayout > ------
#pragma mark
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(wb_collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [_delegate wb_collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (_delegate && [_delegate respondsToSelector:@selector(wb_collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [_delegate wb_collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    }else {
        return 10.f;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (_delegate && [_delegate respondsToSelector:@selector(wb_collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [_delegate wb_collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    }else {
        return 10.f;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [_delegate wb_collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    }else {
        return UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
    }
}

#pragma mark ------ < Getter > ------
#pragma mark
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
