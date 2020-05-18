//
//  CommonSuperFind.h
//  Example1
//
//  Created by WENBO on 2020/5/3.
//  Copyright © 2020 WENBO. All rights reserved.
//

// 如何查找两个子视图的共同父视图？

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonSuperFind : NSObject

- (NSArray <UIView *>*)findCommonSuperView:(UIView *)viewOne
                                 viewOther:(UIView *)viewOther;

@end

NS_ASSUME_NONNULL_END
