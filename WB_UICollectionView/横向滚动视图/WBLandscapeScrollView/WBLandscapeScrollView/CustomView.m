//
//  CustomView.m
//  WBLandscapeScrollView
//
//  Created by WMB on 2018/1/16.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)wb_registerCustomCell {
    [self.collectionView registerClass:[ImageViewCell class] forCellWithReuseIdentifier:kIdentifier];
}

@end
