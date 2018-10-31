//
//  JMWBaseViewController.h
//  Start
//
//  Created by Mr_Lucky on 2018/10/31.
//  Copyright © 2018 jmw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBNavigationButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMWBaseViewController : UIViewController

@property (nonatomic, strong) MyRelativeLayout *rootView;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) WBNavigationButton *backButton;
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) WBNavigationButton *rightButton;

- (void)backAction;
- (void)rightAction;

- (void)setupRightNavigationItem;
- (void)updateBackItemWithImage:(UIImage *)image;
- (void)updateRightItemWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
