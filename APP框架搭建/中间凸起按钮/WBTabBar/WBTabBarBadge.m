//
//  WBTabBarBadge.m
//  Start
//
//  Created by WenBo on 2019/10/14.
//  Copyright © 2019 jmw. All rights reserved.
//

#import "WBTabBarBadge.h"

@implementation WBTabBarBadge

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor colorWithRed:255 / 255
                                           green:38 / 255
                                            blue:0
                                           alpha:1];
    self.textColor = [UIColor whiteColor];
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:10];
    self.clipsToBounds = YES;
    self.automaticHidden = NO;
    self.badgeHeight = 15;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.bounds.size.height / 2.f;
}

- (void)setBadge:(NSString *)badge {
    _badge = badge;
    
    self.text = badge;
    
    CGFloat widths = badge.length * 9 < 20 ? 20 : badge.length * 9;
    if (self.badgeWidth) {
        widths = self.badgeWidth;
    }
    if (badge.integerValue) { // 是数字 或者不为0
        self.hidden = NO; // 不管咋地先取消隐藏
        if (badge.integerValue > 99) {
            self.text = @"99+";
        }
    }else { //
        if (!badge.length) { // 长度为0的空串
            self.hidden = self.automaticHidden;
        }
    }
    CGRect frame = self.frame;
    frame.size.width = widths;
    frame.size.height = self.badgeHeight;
    self.frame = frame;
}

@end
