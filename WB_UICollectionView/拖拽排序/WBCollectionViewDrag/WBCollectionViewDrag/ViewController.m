//
//  ViewController.m
//  WBCollectionViewDrag
//
//  Created by wenbo on 2022/2/28.
//

#import "ViewController.h"
#import "BMLongPressDragCellCollectionView.h"
#import "WBCollectionViewFlowLayout.h"
#import "WBCollectionHeaderView.h"
#import "WBCollectionFooterView.h"

@interface ViewController () <BMLongPressDragCellCollectionViewDelegate, BMLongPressDragCellCollectionViewDataSource>

@property (nonatomic, strong) BMLongPressDragCellCollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray <NSMutableArray *>*dataArray;

@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arr = @[].mutableCopy;
    
    WBCollectionViewFlowLayout *flowLayout = [[WBCollectionViewFlowLayout alloc] init];
    
    _collectionView = [[BMLongPressDragCellCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = UIColor.whiteColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[WBCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [_collectionView registerClass:[WBCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.view addSubview:_collectionView];
}

// MARK: - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (self.view.frame.size.width - 2 * 17 - 3 * 13) / 4;
    return CGSizeMake(floorf(width), 93);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat h = 50;
    if (section > 0) {
        h = 30;
    }
    return CGSizeMake(self.view.frame.size.width, h);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 13;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 11;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat bottom = 21;
    if (section > 0) {
        bottom = 11;
    }
    return UIEdgeInsetsMake(7, 17, bottom, 17);
}

// MARK: - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray[section].count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        WBCollectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
        return header;
    }
    /// 占位footer
    WBCollectionFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
    footer.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5];
    return footer;
}

// MARK: - BMLongPressDragCellCollectionViewDelegate
/// 询问是否能拖动
- (BOOL)dragCellCollectionViewShouldBeginMove:(__kindof BMLongPressDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return YES;
    }
    return NO;
}

/// 是否能交换
- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMLongPressDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.section == destinationIndexPath.section) {
        /// 如果是相同组才可以交换（第一组的cell之间）
        return YES;
    }
    return NO;
}

// MARK: - BMLongPressDragCellCollectionViewDataSource
- (NSArray<NSArray<id> *> *)dataSourceWithDragCellCollectionView:(__kindof BMLongPressDragCellCollectionView *)dragCellCollectionView {
    NSLog(@"%s", __func__);
    return self.dataArray;
}

- (void)dragCellCollectionView:(__kindof BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray<NSArray<id> *> *)newDataArray {
    NSLog(@"%s", __func__);
    self.dataArray = [newDataArray mutableCopy];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // 删除操作
        NSNumber *model = self.dataArray[indexPath.section][indexPath.row];
        NSMutableArray *secArray0 = self.dataArray[indexPath.section];
        [secArray0 removeObject:model];
        NSMutableArray *secArray1 = self.dataArray[1];
        [secArray1 addObject:model];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:secArray1.count-1 inSection:1]];
        
        if (secArray0.count == 0) {
            [secArray0 addObject:[UILabel new]];
            [collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
        }
    } else {
        // 添加操作
        NSNumber *model = self.dataArray[indexPath.section][indexPath.row];
        
        NSMutableArray *secArray1 = self.dataArray[indexPath.section];
        [secArray1 removeObject:model];
        
        NSMutableArray *secArray0 = self.dataArray[0];
        [secArray0 addObject:model];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:secArray0.count-1 inSection:0]];
    }
}

// MARK: - getter
- (NSMutableArray<NSMutableArray *> *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@[[UIView new], [UIView new], [UIView new], [UIView new], [UIView new], [UIView new]].mutableCopy,
                       @[[UIView new], [UIView new], [UIView new], [UIView new], [UIView new], [UIView new]].mutableCopy,
                       @[[UIView new], [UIView new], [UIView new], [UIView new], [UIView new], [UIView new]].mutableCopy,
                       @[[UIView new], [UIView new], [UIView new], [UIView new], [UIView new], [UIView new]].mutableCopy].mutableCopy;
    }
    return _dataArray;
}

@end
