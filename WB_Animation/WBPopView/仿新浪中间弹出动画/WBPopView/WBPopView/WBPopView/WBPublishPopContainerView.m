//
//  WBPublishPopContainerView.m
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import "WBPublishPopContainerView.h"

#import "WBPublishPopBtn.h"

#import "UIView+WBPublishPopAnimation.h"

@interface WBPublishPopContainerView ()

@property (nonatomic,strong) NSMutableArray * homeBtns;
@property (nonatomic,strong) NSMutableArray * visableBtnArray;
@property (nonatomic,assign) BOOL btnCanceled;

@end

@implementation WBPublishPopContainerView


- (void)reloadData {
    NSAssert(self.dataSource, @"WBPublishPopContainerView`s dataSource was nil.");
    NSAssert([self.dataSource respondsToSelector:@selector(numberOfItemsWithCenterView:)], @"WBPublishPopContainerView`s was unimplementation numberOfItemsWithCenterView:.");
    NSAssert([self.dataSource respondsToSelector:@selector(itemWithCenterView:item:)], @"WBPublishPopContainerView`s was unimplementation itemWithCenterView:item:.");
    [self.homeBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.homeBtns removeAllObjects];
    NSInteger count = [self.dataSource numberOfItemsWithCenterView:self];
    NSMutableArray *imtes = @[].mutableCopy;
    for (NSInteger i = 0; i < count; i ++) {
        [imtes addObject:[self.dataSource itemWithCenterView:self item:i]];
    }
    [self layoutBtnsWith:imtes];
    [self btnPositonAnimation];
}

- (void)layoutBtnsWith:(NSArray *)items {
    WBPublishPopItem *item;
    for (NSInteger i = 0; i < items.count; i ++) {
        item = items[i];
        WBPublishPopBtn *btn = [WBPublishPopBtn buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:item.icon] forState:UIControlStateNormal];
        [btn.imageView setContentMode:UIViewContentModeCenter];
        [btn setTitle:item.title forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        CGFloat x = (i % 3) * self.frame.size.width / 3.0;
//        CGFloat y = (i / 3) * self.frame.size.height / 2.0;
        CGFloat y = 0;
         [self.homeBtns addObject:btn];
        CGFloat width = self.frame.size.width / 3.0;
        CGFloat height = 101 * [UIScreen mainScreen].bounds.size.width / 375.f;
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(didCancelBtn:) forControlEvents:UIControlEventTouchDragInside];
        [self addSubview:btn];
        btn.frame = CGRectMake(x, y, width, height);
    }
}

#pragma mark ------ < Animation > ------
#pragma mark
- (void)btnPositonAnimation{
    if (self.visableBtnArray.count <= 0) {
        [self.homeBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.visableBtnArray addObject:obj];
        }];
    }
    self.superview.superview.userInteractionEnabled = NO;
    [self moveInAnimation];
}

- (void)moveInAnimation {
    [self.visableBtnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WBPublishPopBtn *btn = obj;
        CGFloat x = btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
        CGFloat width = btn.frame.size.width;
        CGFloat height = btn.frame.size.height;
        btn.frame = CGRectMake(x, [UIScreen mainScreen].bounds.size.height + y - self.frame.origin.y, width, height);
        btn.alpha = 0.0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:25 options:UIViewAnimationOptionCurveEaseIn animations:^{
                btn.alpha = 1;
                btn.frame = CGRectMake(x, y, width, height);
            } completion:^(BOOL finished) {
                if ([btn isEqual:[self.visableBtnArray lastObject]]) {
                    self.superview.superview.userInteractionEnabled = YES;
                }
            }];
        });
    }];
}

- (void)dismis {
    [self.visableBtnArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        WBPublishPopBtn * btn = obj;
        CGFloat x = btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
        CGFloat width = btn.frame.size.width;
        CGFloat height = btn.frame.size.height;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((self.visableBtnArray.count - idx) * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:5 options:0 animations:^{
                btn.alpha = 0;
                btn.frame = CGRectMake(x, [UIScreen mainScreen].bounds.size.height - self.frame.origin.y + y, width, height);
            } completion:^(BOOL finished) {
                if ([btn isEqual:[self.visableBtnArray firstObject]]) {
                    self.superview.superview.userInteractionEnabled = YES;
                }
            }];
        });
    }];
}

#pragma mark ------ < Event Response > ------
#pragma mark
- (void)didTouchBtn:(WBPublishPopBtn *)btn{
    [btn scalingWithTime:.15 andscal:1.2];
}

- (void)didCancelBtn:(WBPublishPopBtn *)btn{
    self.btnCanceled = YES;
    [btn scalingWithTime:.15 andscal:1];
}

- (void)didClickBtn:(WBPublishPopBtn *)btn {
    if (self.btnCanceled) {
        self.btnCanceled = NO;
        return;
    }
    WBPublishPopItem *item;
    NSInteger index;
    if([self.homeBtns containsObject:btn]){
        index = [self.homeBtns indexOfObject:btn];
        item = [self.dataSource itemWithCenterView:self item:index];
    }
    [btn scalingWithTime:.25 andscal:1];
    [btn scalingWithTime:.25 andscal:1.7];
    [btn fadeOutWithTime:.25];
    [self.visableBtnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        WBPublishPopBtn * b = obj;
        if (b != btn) {
            [b scalingWithTime:.25 andscal:0.3];
            [b fadeOutWithTime:.25];
        }
    }];
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(didSelectItemWithCenterView:andItem:)]) {
        return;
    }
    [self.delegate didSelectItemWithCenterView:self andItem:item];
}

#pragma mark ------ < Getter > ------
#pragma mark
- (NSMutableArray *)homeBtns {
    if (!_homeBtns) {
        _homeBtns = @[].mutableCopy;
    }
    return _homeBtns;
}

- (NSMutableArray *)visableBtnArray
{
    if (!_visableBtnArray) {
        _visableBtnArray = [NSMutableArray array];
    }
    return _visableBtnArray;
}

@end
