//
//  UIViewController+WBTracking.m
//  WBRuntimeMethodSwizzlingDemo
//
//  Created by WMB on 2017/10/30.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "UIViewController+WBTracking.h"
#import <objc/runtime.h>
@implementation UIViewController (WBTracking)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        /** << 方法 > */
        SEL originSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(wb_viewWillAppear);
        
        Method originMethod = class_getInstanceMethod(class, originSelector);
        Method swizzledMehod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originSelector, method_getImplementation(swizzledMehod), method_getTypeEncoding(swizzledMehod));
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        }else {
            method_exchangeImplementations(originMethod, swizzledMehod);
        }
    });
}

- (void)wb_viewWillAppear {
    [self wb_viewWillAppear];
    NSLog(@"viewWillAppear: %@", self);
}

@end
