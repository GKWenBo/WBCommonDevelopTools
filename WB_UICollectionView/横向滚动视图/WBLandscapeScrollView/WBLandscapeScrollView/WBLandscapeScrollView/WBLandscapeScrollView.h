//
//  WBLandscapeScrollView.h
//  WBLandscapeScrollView
//
//  Created by Admin on 2018/1/16.
//  Copyright © 2018年 WENBO. All rights reserved.
//

/** << 横向滚动视图 继承使用 > */

#import <UIKit/UIKit.h>

@class WBLandscapeScrollView;

@protocol WBLandscapeScrollViewDelegate <NSObject>

@optional
/**  < cell点击方法>  */
- (void)wb_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/**  < 行间距 默认：10 >  */
- (CGFloat)wb_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

/**  < item之间间距 默认：10 >  */
- (CGFloat)wb_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

/**  < 组UIEdgeInsets 默认：UIEdgeInsetsMake(10, 10, 10, 10)>  */
- (UIEdgeInsets)wb_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

@required
/**  < item大小 >  */
- (CGSize)wb_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol WBLandscapeScrollViewDataSource <NSObject>

@required
/**  < 注册自定义cell >  */
- (UICollectionViewCell *)wb_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface WBLandscapeScrollView : UIView

@property (nonatomic, assign) id<WBLandscapeScrollViewDelegate> delegate;
@property (nonatomic, assign) id<WBLandscapeScrollViewDataSource> dataSource;

@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;

/**  < 设置数据源并刷新 >  */
- (void)wb_addDataSourceAndReload:(NSArray *)array;

/**
 注册自定义cell
 */
- (void)wb_registerCustomCell;

@end
