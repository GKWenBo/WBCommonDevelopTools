//
//  MedianFind.m
//  Example1
//
//  Created by WENBO on 2020/5/3.
//  Copyright © 2020 WENBO. All rights reserved.
//

#import "MedianFind.h"

@implementation MedianFind

int findMedian(int a[], int aLen) {
    int low = 0;
    int high = aLen - 1;
    
    int mid = (aLen - 1) / 2;
    int div = _PartSort(a, low, high);
    
    while (div != mid) {
        if (mid < div) {
            div = _PartSort(a, low, div - 1);
        } else {
            div = _PartSort(a, div + 1, high);
        }
    }
    return a[mid];
}

int _PartSort(int a[], int start, int end) {
    int low = start;
    int high = end;
    
    /// 取关键字
    int key = a[end];
    while (low < high) {
        /// 左边找比key大的值
        while (low < high && a[low] <= key) {
            ++low;
        }
        
        /// 右边找比key大的值
        while (low < high && a[high] >= key) {
            --high;
        }
        
        if (low < high) {
            int temp = a[low];
            a[low] = a[high];
            a[high] = temp;
        }
    }
    
    int temp = a[high];
    a[high] = a[end];
    a[end] = temp;
    return low;
}

@end
