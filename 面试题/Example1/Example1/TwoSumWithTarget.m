//
//  TwoSumWithTarget.m
//  Example1
//
//  Created by WENBO on 2020/5/3.
//  Copyright © 2020 WENBO. All rights reserved.
//

#import "TwoSumWithTarget.h"

@implementation TwoSumWithTarget

+ (BOOL)towNumSumWithTarget:(int)target
                      array:(NSArray *)array {
    NSMutableArray *findArray = @[].mutableCopy;
    for (int i = 0; i < array.count; i ++) {
        for (int j = i + 1; j < array.count; j ++) {
            if ([array[i] intValue] + [array[j] intValue] == target) {
                [findArray addObject:array[i]];
                [findArray addObject:array[j]];
                
                return YES;
            }
        }
    }
    return NO;
}

@end
