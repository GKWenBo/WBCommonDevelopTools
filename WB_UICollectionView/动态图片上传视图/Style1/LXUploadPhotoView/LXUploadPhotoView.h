//
//  LXUploadPhotoView.h
//  YouFenEr
//
//  Created by xxf on 2017/4/26.
//  Copyright © 2017年 suokeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXUploadPhotoViewFlowLayout.h"

@interface LXUploadPhotoView : UIView

@property (nonatomic, strong) UICollectionView *listView;

@property (nonatomic, strong) NSArray *lx_origindImages; /**< 外部设置 原 图片 数组 */

@property (nonatomic, strong) NSMutableArray *lx_handleImages; /**< 排序 或者 删除 后的 图片数组 */

@property (nonatomic, copy) void(^lx_deleteSelectedWithIndex)(NSInteger index); /**< 删除 某项 */

@property (nonatomic, copy) void(^lx_didTouchedAdd)(); /**< 点击添加图片 */

@property (nonatomic, copy) void(^lx_didSelectedWithIndex)(NSInteger index); /**< 选中某项 */

- (instancetype)initWithFrame:(CGRect)frame
                       layout:(LXUploadPhotoViewFlowLayout *)layout;

/**
 注册自定义cell
 */
- (void)lx_registerClassForCell;

/**
 自定义cell时继承
 
 @param collectionView collectionView description
 @param indexPath indexPath description
 @return return value description
 */
- (UICollectionViewCell *)lx_photoCollectionView:(UICollectionView *)collectionView
                          cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
