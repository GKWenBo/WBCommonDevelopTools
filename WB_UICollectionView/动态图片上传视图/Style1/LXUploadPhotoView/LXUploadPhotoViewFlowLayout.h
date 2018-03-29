//
//  LXUploadPhotoViewFlowLayout.h
//  YouFenEr
//
//  Created by xxf on 2017/4/26.
//  Copyright © 2017年 suokeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXUploadPhotoViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSInteger lx_maxRows; /**< 几行 */

@property (nonatomic, assign) NSInteger lx_numberOfRow; /**< 每行最多几个 */

@property (nonatomic, assign) NSInteger lx_maxCount; /**< 总共多少个 */

@property (nonatomic, assign) BOOL lx_needDrag; /**< 是否需要重新排序，默认NO */

@property (nonatomic, strong) NSString *lx_addImageName; /**< 添加图片的 名称 */

@property (nonatomic, strong) NSString *lx_photoCellDeleteButtonImageName; /**< cell 右上角 删除按钮 imageName */

@end
