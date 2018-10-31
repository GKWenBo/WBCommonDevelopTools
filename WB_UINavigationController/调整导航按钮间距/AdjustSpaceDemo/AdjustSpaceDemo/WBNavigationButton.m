//
//  WBNavigationButton.m
//  AdjustSpaceDemo
//
//  Created by Mr_Lucky on 2018/10/31.
//  Copyright © 2018 wenbo. All rights reserved.
//

#import "WBNavigationButton.h"

@implementation WBNavigationButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIEdgeInsets)alignmentRectInsets {
    if (UIEdgeInsetsEqualToEdgeInsets(self.alignmentRectInsetsOverride, UIEdgeInsetsZero)) {
        return super.alignmentRectInsets;
    } else {
        return self.alignmentRectInsetsOverride;
    }
}



@end
