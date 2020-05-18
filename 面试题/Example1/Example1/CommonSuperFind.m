//
//  CommonSuperFind.m
//  Example1
//
//  Created by WENBO on 2020/5/3.
//  Copyright © 2020 WENBO. All rights reserved.
//

#import "CommonSuperFind.h"

@implementation CommonSuperFind

- (NSArray <UIView *>*)findCommonSuperView:(UIView *)viewOne
                                 viewOther:(UIView *)viewOther {
    NSArray *arrayOne = [self findSuperViewForView:viewOne];
    NSArray *arrayTwo = [self findSuperViewForView:viewOther];
    
    NSMutableArray *result = @[].mutableCopy;
    int i = 0;
    while (i < MIN((int)arrayOne.count, (int)arrayTwo.count)) {
        UIView *superOne = arrayOne[arrayOne.count - i -1];
        UIView *superTwo = arrayOne[arrayTwo.count - i -1];
        
        if (superOne == superTwo) {
            [result addObject:superOne];
        }else {
            break;
        }
    }
    return result;
}

- (NSArray <UIView *>*)findSuperViewForView:(UIView *)view {
    UIView *superView = view.superview;
    NSMutableArray *tempArray = @[].mutableCopy;
    while (superView) {
        [tempArray addObject:superView];
        superView = superView.superview;
    }
    return tempArray;
}

@end
