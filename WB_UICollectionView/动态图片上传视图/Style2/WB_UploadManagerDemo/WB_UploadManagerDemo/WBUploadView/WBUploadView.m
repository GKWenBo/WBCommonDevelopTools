//
//  WB_UploadView.m
//  WB_UploadManagerDemo
//
//  Created by Admin on 2017/7/11.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBUploadView.h"
#import "WBUploadImageViewCell.h"
#import "WBUploadViewConfig.h"
#import "LxGridViewFlowLayout.h"
static NSString * kIdentifier = @"WB_UploadImageViewCell";
@interface WBUploadView () <UICollectionViewDelegate,UICollectionViewDataSource,WB_UploadImageViewCellDelegate>
{
    NSInteger _maxNumRows;
    NSInteger _rowCount;
    NSInteger _maxCount;
    CGFloat _leftRightMargin;
    CGFloat _topBottomMargin;
    CGFloat _itemSpacing;
    
}
@property (nonatomic, strong) LxGridViewFlowLayout *flowLayout;
@end
@implementation WBUploadView

#pragma mark -- 视图初始化
#pragma mark
- (instancetype)initWithFrame:(CGRect)frame maxNumRows:(NSInteger)maxNumRows rowCount:(NSInteger)rowCount maxCount:(NSInteger)maxCount leftRightMargin:(CGFloat)leftRightMargin topBottomMargin:(CGFloat)topBottomMargin itemSpacing:(CGFloat)itemSpacing {
    self = [super initWithFrame:frame];
    if (self) {
        _maxNumRows = maxNumRows > 0 ? maxNumRows : 3;
        _rowCount = rowCount > 0 ? rowCount : 3;
        _maxCount = maxCount > 0 ? maxCount : 9 ;
        _leftRightMargin = leftRightMargin > 0 ? leftRightMargin : 10;
        _topBottomMargin = topBottomMargin > 0 ? topBottomMargin : 10;
        _itemSpacing = itemSpacing > 0 ? itemSpacing : 10;
        
        [self setupUI];
    }
    return self;
}

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    [self addSubview:self.collectionView];
    /** 注册cell */
    [self.collectionView registerClass:[WBUploadImageViewCell class] forCellWithReuseIdentifier:kIdentifier];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self wb_updateFrame];
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
    [self wb_updateFrame];
}

- (void)wb_updateFrame {
    NSInteger row = self.editedImageArray.count / _rowCount + 1;
    if (row > _maxNumRows) {
        row  = _maxNumRows;
    }
    CGFloat height = self.flowLayout.itemSize.width * row + self.flowLayout.sectionInset.top + self.flowLayout.sectionInset.bottom + self.flowLayout.minimumLineSpacing * (row - 1);
    self.height = height;
}

#pragma mark -- WB_UploadImageViewCellDelegate
#pragma mark
- (void)wb_upLoadImageViewCell:(WBUploadImageViewCell *)cell deleteBtn:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    NSIndexPath * indexPath = [self.collectionView indexPathForItemAtPoint:cell.center];
    [self.collectionView performBatchUpdates:^{
        [weakSelf.editedImageArray removeObjectAtIndex:indexPath.row];
        [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [weakSelf wb_updateFrame];
        if (_delegate && [_delegate respondsToSelector:@selector(wb_upLoadView:deleteIdx:)]) {
            [_delegate wb_upLoadView:self deleteIdx:indexPath.row];
        }
        [weakSelf.collectionView reloadData];
    }];
}

#pragma mark -- UICollectionViewDelegate,UICollectionViewDataSource
#pragma mark
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.editedImageArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WBUploadImageViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.item == self.editedImageArray.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"test"];
        cell.deleteBtn.hidden = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.editedImageArray.count) {
        if (_maxCount - self.editedImageArray.count <= 0) return;
        if (_delegate && [_delegate respondsToSelector:@selector(wb_addCellClicked)]) {
            [_delegate wb_addCellClicked];
        }
    } else {
        // 预览照片或者视频
    }
}

#pragma mark -- LxGridViewDataSource
#pragma mark
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < self.editedImageArray.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < self.editedImageArray.count && destinationIndexPath.item < self.editedImageArray.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = self.editedImageArray[sourceIndexPath.item];
    [self.editedImageArray removeObjectAtIndex:sourceIndexPath.item];
    [self.editedImageArray insertObject:image atIndex:destinationIndexPath.item];
    [_collectionView reloadData];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark -- Getter And Setter
#pragma mark
- (LxGridViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[LxGridViewFlowLayout alloc]init];
        CGFloat itemW = floorf((SCREEN_WIDTH - 2 * _leftRightMargin - (_rowCount - 1) * _itemSpacing) / _rowCount);
        _flowLayout.itemSize = CGSizeMake(itemW, itemW);
        _flowLayout.minimumLineSpacing = _itemSpacing;
        _flowLayout.sectionInset = UIEdgeInsetsMake(_topBottomMargin, _leftRightMargin, _topBottomMargin, _leftRightMargin);
        _flowLayout.minimumInteritemSpacing = _itemSpacing;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

- (void)setImageDataArray:(NSArray *)imageDataArray {
    _imageDataArray = imageDataArray;
    [self.editedImageArray removeAllObjects];
    [self.editedImageArray addObjectsFromArray:imageDataArray];
    [self wb_updateFrame];
    [self.collectionView reloadData];
}

- (NSMutableArray *)editedImageArray {
    if (!_editedImageArray) {
        _editedImageArray = @[].mutableCopy;
    }
    return _editedImageArray;
}

@end
