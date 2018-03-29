//
//  WB_UploadImageCell.h
//  WB_UploadManagerDemo
//
//  Created by Admin on 2017/7/11.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBUploadImageViewCell;
@protocol WB_UploadImageViewCellDelegate <NSObject>
/** 点击删除按钮 */
- (void)wb_upLoadImageViewCell:(WBUploadImageViewCell *)cell deleteBtn:(UIButton *)sender;
@end
@interface WBUploadImageViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deleteBtn;/** 删除按钮 */
@property (nonatomic, assign) id<WB_UploadImageViewCellDelegate> delegate;

- (UIView *)snapshotView;
@end
