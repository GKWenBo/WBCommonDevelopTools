//
//  LXPhotoCollectionViewCell.h
//  LXPhotoViewDemo
//
//  Created by xxf on 2017/4/27.
//  Copyright © 2017年 suokeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXPhotoCollectionViewCell;
@protocol LXPhotoCollectionViewCellDelegate <NSObject>

- (void)clickCellDeleteButton:(LXPhotoCollectionViewCell *)cell;

@end

@interface LXPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *photoIV;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, weak) id<LXPhotoCollectionViewCellDelegate> delegate;


@end
