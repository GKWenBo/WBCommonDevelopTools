//
//  UINavigationItem+WBFixSpace.m
//  UINavigationItemDemo
//
//  Created by WMB on 2017/9/26.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "UINavigationItem+WBFixSpace.h"
#import "UIBarButtonItem+WBCreate.h"
#import "NSObject+WBRuntime.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, WBBarViewPosition) {
    WBBarViewPositionLeft,
    WBBarViewPositionRight
};

@interface BarView : UIView

@property (nonatomic,assign) WBBarViewPosition position;
@property (nonatomic,assign) BOOL applied;

@end

@implementation BarView

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.applied || [[[UIDevice currentDevice] systemVersion] floatValue]  < 11) return;
    UIView *view = self;
    while (![view isKindOfClass:UINavigationBar.class] && view.superview) {
        view = [view superview];
        if ([view isKindOfClass:UIStackView.class] && view.superview) {
            if (self.position == WBBarViewPositionLeft) {
                for (NSLayoutConstraint *constraint in view.superview.constraints) {
                    if (([constraint.firstItem isKindOfClass:UILayoutGuide.class] &&
                         constraint.firstAttribute == NSLayoutAttributeTrailing)) {
                        [view.superview removeConstraint:constraint];
                    }
                }
                [view.superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view.superview
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1.0
                                                                            constant:0]];
                self.applied = YES;
            } else if (self.position == WBBarViewPositionRight) {
                for (NSLayoutConstraint *constraint in view.superview.constraints) {
                    if (([constraint.firstItem isKindOfClass:UILayoutGuide.class] &&
                         constraint.firstAttribute == NSLayoutAttributeLeading)) {
                        [view.superview removeConstraint:constraint];
                    }
                }
                [view.superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeTrailing
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view.superview
                                                                           attribute:NSLayoutAttributeTrailing
                                                                          multiplier:1.0
                                                                            constant:0]];
                self.applied = YES;
            }
            break;
        }
    }
}

@end

@implementation UINavigationItem (WBFixSpace)
+ (void)load {
    [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItem:)
                                 swizzledSel:@selector(sx_setLeftBarButtonItem:)];
    [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItem:)
                                 swizzledSel:@selector(sx_setRightBarButtonItem:)];
}

-(void)sx_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem{
    if (leftBarButtonItem.customView) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
            UIView *customView = leftBarButtonItem.customView;
            BarView *barView = [[BarView alloc]initWithFrame:customView.bounds];
            [barView addSubview:customView];
            customView.center = barView.center;
            [barView setPosition:WBBarViewPositionLeft];
            [self setLeftBarButtonItems:nil];
            [self sx_setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:barView]];
        }else {
            [self sx_setLeftBarButtonItem:nil];
            [self setLeftBarButtonItems:@[[self fixedSpaceWithWidth:-20], leftBarButtonItem]];
        }
    }else {
        [self setLeftBarButtonItems:nil];
        [self sx_setLeftBarButtonItem:leftBarButtonItem];
    }
}

-(void)sx_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem{
    if (rightBarButtonItem.customView) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
            UIView *customView = rightBarButtonItem.customView;
            BarView *barView = [[BarView alloc]initWithFrame:customView.bounds];
            [barView addSubview:customView];
            customView.center = barView.center;
            [barView setPosition:WBBarViewPositionRight];
            [self setRightBarButtonItems:nil];
            [self sx_setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:barView]];
        } else {
            [self sx_setRightBarButtonItem:nil];
            [self setRightBarButtonItems:@[[self fixedSpaceWithWidth:-20], rightBarButtonItem]];
        }
    }else {
        [self setRightBarButtonItems:nil];
        [self sx_setRightBarButtonItem:rightBarButtonItem];
    }
}

-(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end
