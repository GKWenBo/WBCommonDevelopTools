//
//  WBTabBarBadge.h
//  Start
//
//  Created by WenBo on 2019/10/14.
//  Copyright © 2019 jmw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBTabBarBadge : UILabel

//文字或数字
@property (nonatomic, copy) NSString *badge;
//角标高度 默认：15
@property (nonatomic, assign) CGFloat badgeHeight;
//角标宽度 默认：0
@property (nonatomic, assign) CGFloat badgeWidth;
//为0是否自动隐藏
@property (nonatomic, assign) BOOL automaticHidden;


@end

NS_ASSUME_NONNULL_END
