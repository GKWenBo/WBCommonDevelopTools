//
//  WBTabBarConfigModel.m
//  Start
//
//  Created by WenBo on 2019/10/14.
//  Copyright © 2019 jmw. All rights reserved.
//

#import "WBTabBarConfigModel.h"

@implementation WBTabBarConfigModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.normalColor = [UIColor grayColor];
    self.selectColor = [UIColor colorWithRed:59 / 255.0
                                       green:185 / 255.0
                                        blue:222 / 255.0
                                       alpha:1];
    self.plusItemHeight = 20.f;
    self.imageTextMargin = 5.f;
    self.componentMargin = UIEdgeInsetsMake(5, 5, 5, 5);
    self.isRepeatClick = NO;
}

// MARK:getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIImageView *)icomImgView {
    if (!_icomImgView) {
        _icomImgView = [UIImageView new];
        _icomImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icomImgView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
    }
    return _backgroundImageView;
}

@end
