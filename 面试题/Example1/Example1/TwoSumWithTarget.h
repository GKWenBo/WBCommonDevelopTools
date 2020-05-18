//
//  TwoSumWithTarget.h
//  Example1
//
//  Created by WENBO on 2020/5/3.
//  Copyright © 2020 WENBO. All rights reserved.
//

/// 如何给定一个整数数组和一个目标值，找出数组中和为目标值的两个数。


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TwoSumWithTarget : NSObject

+ (BOOL)towNumSumWithTarget:(int)target
                      array:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
