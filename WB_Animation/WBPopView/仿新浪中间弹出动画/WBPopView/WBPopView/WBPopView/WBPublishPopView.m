//
//  WBPopView.m
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import "WBPublishPopView.h"

#import "WBPublishPopContainerView.h"
#import "WBPublishPopBottomBar.h"
#import "UIView+WBPublishPopAnimation.h"

@interface WBPublishPopView () <WBPublishPopContainerViewDelegate,WBPublishPopContainerViewDataSource>

@property (nonatomic,copy) WBDidSelectedBlock selectedBlock;
@property (nonatomic,strong) NSArray *items;

@property (nonatomic, strong) WBPublishPopContainerView *containerView;
@property (nonatomic, strong) WBPublishPopBottomBar *bottomBar;

@end

@implementation WBPublishPopView

#pragma mark ------ < 初始化 > ------
#pragma mark
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.containerView];
        [self.containerView addSubview:self.bottomBar];
    }
    return self;
}

+ (instancetype)wb_showToView:(UIView *)view andImages:(NSArray *)imageArray andTitles:(NSArray *)titles andSelectBlock:(WBDidSelectedBlock)block {
    NSMutableArray *items = @[].mutableCopy;
    for (NSInteger index = 0; index < imageArray.count; index ++) {
        WBPublishPopItem *item = [[WBPublishPopItem alloc]initWithTitle:titles[index] Icon:imageArray[index]];
        [items addObject:item];
    }
    [self viewNotEmpty:view];
    WBPublishPopView *popView = [[WBPublishPopView alloc]initWithFrame:view.bounds];
    [view addSubview:popView];
    popView.selectedBlock = block;
    [popView fadeInWithTime:0.25];
    popView.items = items;
    [popView showItems];
    return popView;
}

+ (void)viewNotEmpty:(UIView *)view{
    if (view == nil) {
        view = (UIView *)[[UIApplication sharedApplication] delegate];
    }
}

#pragma mark ------ < Private Method > ------
#pragma mark
- (void)showItems {
    [self.containerView reloadData];
}

- (void)hide {
    [WBPublishPopView hideWithView:self];
}

- (void)hideItems{
    [self.containerView dismis];
}


+ (void)hideWithView:(UIView *)view {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view fadeOutWithTime:0.35];
    });
}

#pragma mark ------ < WBPublishPopContainerViewDelegate,WBPublishPopContainerViewDataSource > ------
#pragma mark
- (NSInteger)numberOfItemsWithCenterView:(WBPublishPopContainerView *)centerView
{
    return self.items.count;
}

- (WBPublishPopItem *)itemWithCenterView:(WBPublishPopContainerView *)centerView item:(NSInteger)item
{
    return self.items[item];
}

- (void)didSelectItemWithCenterView:(WBPublishPopContainerView *)centerView andItem:(WBPublishPopItem *)item {
    if (self.selectedBlock) {
        self.selectedBlock(item);
    }
    [self hide];
}

#pragma mark ------ < Touch > ------
#pragma mark
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.bottomBar btnResetPosition];
    [self.bottomBar fadeOutWithTime:.25];
    [self hideItems];
    [self hide];
}

#pragma mark ------ < Getter > ------
#pragma mark
- (WBPublishPopBottomBar *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[WBPublishPopBottomBar alloc]initWithFrame:CGRectMake(0, [self viewHeight] - [WBPublishPopBottomBar bottomViewHeight], self.frame.size.width, [WBPublishPopBottomBar bottomViewHeight])];
    }
    return _bottomBar;
}

- (WBPublishPopContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[WBPublishPopContainerView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - [self viewHeight], self.frame.size.width, [self viewHeight])];
        _containerView.delegate = self;
        _containerView.dataSource = self;
        _containerView.clipsToBounds = NO;
    }
    return _containerView;
}

- (CGFloat)viewHeight {
    return 115 * [UIScreen mainScreen].bounds.size.width / 375.f + [WBPublishPopBottomBar bottomViewHeight];
}

@end
