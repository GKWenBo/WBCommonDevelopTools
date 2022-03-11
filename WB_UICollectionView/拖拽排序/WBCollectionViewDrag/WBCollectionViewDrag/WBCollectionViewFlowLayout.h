//
//  WBCollectionViewFlowLayout.h
//  WBCollectionViewDrag
//
//  Created by wenbo on 2022/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBCollectionViewFlowLayout : UICollectionViewFlowLayout

/// 圆角矩形左间距 默认：6
@property (nonatomic, assign) CGFloat roundLeftPadding;
/// 圆角矩形底部距离元素距离 默认：12
@property (nonatomic, assign) CGFloat roundBottomPadding;


@end

NS_ASSUME_NONNULL_END
