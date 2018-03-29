//
//  LXUploadPhotoViewFlowLayout.m
//  YouFenEr
//
//  Created by xxf on 2017/4/26.
//  Copyright © 2017年 suokeer. All rights reserved.
//

#import "LXUploadPhotoViewFlowLayout.h"

@implementation LXUploadPhotoViewFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        _lx_maxRows = 2;
        _lx_numberOfRow = 4;
        _lx_maxCount = 8;
        _lx_needDrag = NO;
    }
    return self;
}

@end
