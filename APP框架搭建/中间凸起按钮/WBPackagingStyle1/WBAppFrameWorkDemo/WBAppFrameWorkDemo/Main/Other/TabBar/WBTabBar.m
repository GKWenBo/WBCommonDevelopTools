//
//  WBTabBar.m
//  WBAppFrameWorkDemo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBTabBar.h"

@interface WBTabBar ()

@property (nonatomic, strong) UIButton *plusBtn;

@end

@implementation WBTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.plusBtn];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark ------ < Layout > ------
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
    Class class = NSClassFromString(@"UITabBarButton");
    self.plusBtn.center = CGPointMake(self.width * 0.5, self.height * 0.2);
    NSInteger btnIndex = 0;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:class]) {
            subView.width = self.width / 3;
            subView.left = subView.width * btnIndex;
            btnIndex ++;
            if (btnIndex == 1) {
                btnIndex ++;
            }
        }
    }
}

#pragma mark ------ < Event Response > ------
#pragma mark
- (void)plusBtnClicked:(UIButton *)sender {
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(tabBarPlusBtnClicked:plusBtn:)]) {
        [_myDelegate tabBarPlusBtnClicked:self plusBtn:sender];
    }
}

#pragma mark -- Getter And Setter
#pragma mark
- (UIButton *)plusBtn {
    if (!_plusBtn) {
        _plusBtn = [[UIButton alloc]init];
        [_plusBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [_plusBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        [_plusBtn addTarget:self action:@selector(plusBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _plusBtn.frame = CGRectMake(0, 0, _plusBtn.imageView.image.size.width, _plusBtn.imageView.image.size.height);
    }
    return _plusBtn;
}

@end
