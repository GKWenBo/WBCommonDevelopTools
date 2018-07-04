//
//  WBTabBar.m
//  WBAppFrameWorkDemo
//
//  Created by WMB on 2017/10/10.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBTabBar.h"
#define TABBAR_BTN_TAG 9999
@interface WBTabBar ()
{
    UIButton *plusBtn;
    NSInteger currentIndex;/**  < 记录当前选中按钮下标 >  */
}
/**  < 自定义tabBarItem 标题 >  */
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *normalImageArray;
@property (nonatomic, strong) NSArray *selectedImageArray;

@end

@implementation WBTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultConfig];
        [self setupUI];
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

#pragma mark ------ < Setup UI > ------
#pragma mark
- (void)defaultConfig {
    _plusBtnIndex = 1000;
}

- (void)setupUI {
    CGFloat btn_width = self.width / self.normalImageArray.count;
    [self.normalImageArray enumerateObjectsUsingBlock:^(NSString *  normalImageName, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.selectedImageArray[idx]] forState:UIControlStateSelected];
        button.adjustsImageWhenHighlighted = NO;
        if (idx == 1) {
            button.frame = CGRectMake(0, 0, btn_width, self.height + 2 * kWBMargin);
            button.center = CGPointMake(self.centerX, kWBMargin);
            plusBtn = button;
        }else {
            button.frame = CGRectMake(idx * btn_width, self.top, btn_width, self.height);
        }
        button.tag = TABBAR_BTN_TAG + idx;
        [button addTarget:self action:@selector(barBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (idx == 0) {
            button.selected = YES;
        }
        [self addSubview:button];
    }];
    currentIndex = 0;
}

#pragma mark ------ < Event Response > ------
#pragma mark
- (void)barBtnClicked:(UIButton *)sender {
    NSInteger tag = sender.tag - TABBAR_BTN_TAG;
    if (currentIndex == tag) {
        return;
    }
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(wb_tabBarPlusBtnClicked:selectedIndex:isPlusBtn:)]) {
        [_myDelegate wb_tabBarPlusBtnClicked:self selectedIndex:tag isPlusBtn:tag == self.plusBtnIndex ? YES : NO];
    }
    /**  < 选中取消选中 >  */
    [self wb_selectedTabBarItemAtIndex:tag];
    /**  < 添加动画 >  */
    [self addTabBarButtonAnimation:sender];
}

- (void)wb_selectedTabBarItemAtIndex:(NSInteger)selectedIndex {
    UIButton *oldBtn = (UIButton *)[self viewWithTag:currentIndex + TABBAR_BTN_TAG];
    oldBtn.selected = NO;
    
    UIButton *selectedBtn = (UIButton *)[self viewWithTag:selectedIndex + TABBAR_BTN_TAG];
    selectedBtn.selected = YES;
    currentIndex = selectedIndex;
}

#pragma mark -- TabBarButton Animations
#pragma mark
- (void)addTabBarButtonAnimation:(UIButton *)button {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.1,@0.9,@1.0];
    animation.duration = 0.3;
    animation.calculationMode = kCAAnimationCubic;
    [button.imageView.layer addAnimation:animation forKey:nil];
}

#pragma mark -- 重写hitTest方法，去监听发布按钮的点击
#pragma mark
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (self.hidden == NO) {
        CGPoint p = [self convertPoint:point toView:plusBtn];
        if ([plusBtn pointInside:p withEvent:event]) {
            return plusBtn;
        }
    }
    return view;
}

#pragma mark -- Getter And Setter
#pragma mark
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"",
                        @"",
                        @""];
    }
    return _titleArray;
}

- (NSArray *)normalImageArray {
    if (!_normalImageArray) {
        _normalImageArray = @[@"home_normal",
                              @"post_normal",
                              @"account_normal"];
    }
    return _normalImageArray;
}

- (NSArray *)selectedImageArray {
    if (!_selectedImageArray) {
        _selectedImageArray = @[@"home_highlight",
                                @"post_normal",
                                @"account_highlight"];
    }
    return _selectedImageArray;
}

@end
