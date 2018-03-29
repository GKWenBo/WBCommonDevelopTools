//
//  WBPopBottomBar.m
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import "WBPublishPopBottomBar.h"
#import "UIView+WBPublishPopAnimation.h"
@implementation WBPublishPopBottomBar

#pragma mark ------ < 初始化 > ------
#pragma mark
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark ------ < 设置UI > ------
#pragma mark
- (void)setupUI {
    [self addSubview:self.closeButton];
    [self.closeButton RevolvingWithTime:0.25f andDelta:(M_PI_2)];
}

//恢复按钮位置
- (void)btnResetPosition{
    if (self.closeButton) {
        [self.closeButton RevolvingWithTime:.25 andDelta:0];
    }
}

#pragma mark ------ < Getter > ------
#pragma mark
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(0, 0, [WBPublishPopBottomBar bottomViewHeight] / 2, [WBPublishPopBottomBar bottomViewHeight] / 2);
         _closeButton.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        [_closeButton setImage:[UIImage imageNamed:@"cancelPublish_icon"] forState:UIControlStateNormal];
        _closeButton.userInteractionEnabled = NO;
    }
    return _closeButton;
}
+ (CGFloat)bottomViewHeight {
    return 57 * [UIScreen mainScreen].bounds.size.width / 375.f;
}

@end
