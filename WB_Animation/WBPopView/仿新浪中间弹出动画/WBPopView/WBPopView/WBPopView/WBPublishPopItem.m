//
//  WBItem.m
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import "WBPublishPopItem.h"

@implementation WBPublishPopItem

- (instancetype)initWithTitle:(NSString *)title Icon:(NSString *)icon {
    if (self = [super init]) {
        _title = title;
        _icon  = icon;
    }
    return self;
}

@end
