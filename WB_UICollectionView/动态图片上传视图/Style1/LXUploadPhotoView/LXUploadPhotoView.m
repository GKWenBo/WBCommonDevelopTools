//
//  LXUploadPhotoView.m
//  YouFenEr
//
//  Created by xxf on 2017/4/26.
//  Copyright © 2017年 suokeer. All rights reserved.
//

#import "LXUploadPhotoView.h"

#import "LXPhotoCollectionViewCell.h"

#import "ImageManager.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "Masonry.h"

#import "UIView+LXFrame.h"

static NSString *kCellIdentifier = @"kCellIdentifier";

@interface LXUploadPhotoView ()<UICollectionViewDelegate, UICollectionViewDataSource, LXPhotoCollectionViewCellDelegate> {
    LXUploadPhotoViewFlowLayout *flowLayout;
}

@property (nonatomic, strong) NSMutableArray *thumbanailImages; /**< 展示的时候处理了的缩略图 */

@end

@implementation LXUploadPhotoView

- (instancetype)initWithFrame:(CGRect)frame
                       layout:(LXUploadPhotoViewFlowLayout *)layout{
    if (self = [super initWithFrame:frame]) {
        
        flowLayout = layout;
        
        [self setup];
    }
    return self;
}

- (void)setup {
    self.clipsToBounds = YES;
    
    self.thumbanailImages = [NSMutableArray array];
    self.lx_handleImages = [NSMutableArray array];
    
    self.listView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.scrollEnabled = NO;
    self.listView.scrollsToTop = NO;
    [self addSubview:self.listView];
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
    }];
    
    [self lx_registerClassForCell];
    
    if (flowLayout.lx_needDrag) {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognized:)];
        [self.listView addGestureRecognizer:longPress];
    }
    
    [self resetViewFrame];
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.lx_handleImages.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self lx_photoCollectionView:collectionView cellForItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.lx_handleImages.count)//点击了上传图片
    {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
            NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
            NSString *message = [NSString stringWithFormat:@"请打开 设置 - 隐私 - 相册 - 允许 %@ 访问相册",appName];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请允许访问相册" message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        LXPhotoCollectionViewCell *cell = (LXPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (cell.photoIV.hidden == YES) {
            return;
        }
        
        if (_lx_didTouchedAdd) {
            _lx_didTouchedAdd();
        }
    } else {
        if (_lx_didSelectedWithIndex) {
            _lx_didSelectedWithIndex(indexPath.row);
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self resetViewFrame];
}

/**
 重设frame，因为至少有一个item，所以row + 1
 */
- (void)resetViewFrame {
    NSInteger row = self.lx_handleImages.count / flowLayout.lx_numberOfRow + 1;
    
    if (row > flowLayout.lx_maxRows) {
        row = flowLayout.lx_maxRows;
    }
    
    CGFloat height = flowLayout.itemSize.width * row + flowLayout.sectionInset.top + flowLayout.sectionInset.bottom + flowLayout.minimumLineSpacing * (row - 1);
    
    self.lx_height = height;
}

- (void)longPressGestureRecognized:(id)sender
{
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.listView];
    NSIndexPath *indexPath = [self.listView indexPathForItemAtPoint:location];
    
    if (indexPath.row == self.lx_handleImages.count)
    {
        indexPath = nil;
    }
    static UIView *snapshot = nil;
    static NSIndexPath *sourceIndexPath = nil;
    
    switch (state)
    {
        case UIGestureRecognizerStateBegan:
        {
            if (indexPath)
            {
                sourceIndexPath = indexPath;
                UICollectionViewCell *cell = [self.listView cellForItemAtIndexPath:indexPath];
                snapshot = [self customSnapshoFromView:cell];
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.listView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    
                    // Fade out.
                    cell.alpha = 0.0;
                } completion:nil];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint center = snapshot.center;
            center.y = location.y;
            center.x = location.x;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath])
            {
                
                
                // ... update data source.
                [self.lx_handleImages exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                [self.thumbanailImages exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                [self.listView moveItemAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
        default:
        {
            // Clean up.
            UICollectionViewCell *cell = [self.listView cellForItemAtIndexPath:sourceIndexPath];
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                
                // Undo the fade-out effect we did.
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            sourceIndexPath = nil;
            break;
        }
    }
}

#pragma mark - Helper methods

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView
{
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

#pragma mark - PhotoCollectionViewCellDelegate
- (void)clickCellDeleteButton:(LXPhotoCollectionViewCell *)cell {
    
    __weak typeof(self) weakSelf = self;
    
    NSIndexPath *indexPath = [weakSelf.listView indexPathForItemAtPoint:cell.center];
    
    [self.listView performBatchUpdates:^{
        
        [weakSelf.thumbanailImages removeObjectAtIndex:indexPath.row];
        
        [weakSelf.lx_handleImages removeObjectAtIndex:indexPath.row];
        
        [weakSelf.listView deleteItemsAtIndexPaths:@[indexPath]];
        
    } completion:^(BOOL finished) {
        [self resetViewFrame];
        
        if (_lx_deleteSelectedWithIndex) {
            _lx_deleteSelectedWithIndex(indexPath.row);
        }
        
        [self.listView reloadData];
    }];
    
}


#pragma mark - configcell data

- (void)setLx_origindImages:(NSArray *)lx_origindImages {
    _lx_origindImages = lx_origindImages;
    
    [_lx_handleImages removeAllObjects];
    [_lx_handleImages addObjectsFromArray:lx_origindImages];
    
    [self resetViewFrame];
    
    [self creatThumbnailImages];
}

- (void)creatThumbnailImages {
    
    //    [SVProgressHUD showWithStatus:@"正在处理..."]; //影响不大，去掉缩放图片的提示
    
    NSMutableArray *array = [NSMutableArray array];
    
    dispatch_queue_t queue = dispatch_queue_create("images", DISPATCH_QUEUE_SERIAL);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_apply(_lx_handleImages.count, queue, ^(size_t index) {
        dispatch_group_async(group, queue, ^{
            id object = _lx_handleImages[index];
            if ([object isKindOfClass:[NSString class]]) {
                [array addObject:object];
            } else {
                UIImage *tmpImage = (UIImage *)object;
                
                CGFloat width = flowLayout.itemSize.width;
                
                UIImage *image = [ImageManager screenshot:CGSizeMake(width * 3, width * 3) withImage:tmpImage];
                if (image) {
                    [array addObject:image];
                }
            }
        });
    });
    
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //            [SVProgressHUD dismiss];
            self.thumbanailImages = array;
            [self.listView reloadData];
            
        });
    });
}

#pragma mark - public 可继承
- (void)lx_registerClassForCell {
    [self.listView registerClass:[LXPhotoCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
}


- (UICollectionViewCell *)lx_photoCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    if (flowLayout.lx_photoCellDeleteButtonImageName.length == 0) {
        cell.deleteButton.hidden = YES;
    } else {
        cell.deleteButton.hidden = indexPath.row == self.thumbanailImages.count ;
        
        [cell.deleteButton setImage:[UIImage imageNamed:flowLayout.lx_photoCellDeleteButtonImageName] forState:UIControlStateNormal];
    }
    
    if (indexPath.row == self.lx_handleImages.count)
    {
        cell.photoIV.image = [UIImage imageNamed:flowLayout.lx_addImageName];
    }else
    {
        //        cell.backgroundColor = [UIColor grayColor];
        id object = self.thumbanailImages[indexPath.row];
        cell.photoIV.image = object;
        
    }
    
    if (indexPath.row == flowLayout.lx_maxCount) {
        cell.photoIV.hidden = YES;
    } else {
        cell.photoIV.hidden = NO;
    }

    
    return cell;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
