//
//  JMWBaseViewController.m
//  Start
//
//  Created by Mr_Lucky on 2018/10/31.
//  Copyright © 2018 jmw. All rights reserved.
//

#import "JMWBaseViewController.h"

@interface JMWBaseViewController ()

@property (nonatomic, strong) UIBarButtonItem *leftSpacer;
@property (nonatomic, strong) UIBarButtonItem *rightSpacer;

@end

@implementation JMWBaseViewController

// MARK:Life Cycle
- (void)loadView {
    MyRelativeLayout *rootView = [[MyRelativeLayout alloc]init];
    self.rootView = rootView;
    self.view = _rootView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    if (@available(iOS 11.0, *)) {
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self setupLeftBackItem];
}

// MARK:设置返回按钮
- (void)setupLeftBackItem {
    self.navigationItem.leftBarButtonItems = @[self.leftSpacer,
                                               self.backItem];
}

- (void)setupRightNavigationItem {
    self.navigationItem.rightBarButtonItems = @[self.rightSpacer,
                                                self.rightItem];
}

- (void)updateBackItemWithImage:(UIImage *)image {
    [self.backButton setImage:image
                     forState:UIControlStateNormal];
    [self.backButton sizeToFit];
    
    self.navigationItem.leftBarButtonItems = @[self.leftSpacer,
                                               self.backItem];
}

- (void)updateRightItemWithImage:(UIImage *)image {
    [self.rightButton setImage:image
                     forState:UIControlStateNormal];
    [self.rightButton sizeToFit];
    
    self.navigationItem.leftBarButtonItems = @[self.rightSpacer,
                                               self.rightItem];
}

// MARK:Event Response
- (void)backAction {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (void)rightAction {
    
}

// MARK:Getter
- (WBNavigationButton *)backButton {
    if (!_backButton) {
        _backButton = [WBNavigationButton buttonWithType:UIButtonTypeCustom];
        _backButton.alignmentRectInsetsOverride = UIEdgeInsetsMake(0, 8, 0, -8);
        [_backButton setImage:[UIImage imageNamed:@"back_hei"] forState:UIControlStateNormal];
        [_backButton wb_addTarget:self
                           action:@selector(backAction)];
        [_backButton sizeToFit];
    }
    return _backButton;
}

- (UIBarButtonItem *)backItem {
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backButton];
    }
    return _backItem;
}

- (WBNavigationButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [WBNavigationButton buttonWithType:UIButtonTypeCustom];
        _rightButton.alignmentRectInsetsOverride = UIEdgeInsetsMake(0, 8, 0, -8);
        [_rightButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [_rightButton wb_addTarget:self
                            action:@selector(rightAction)];
        [_rightButton sizeToFit];
    }
    return _rightButton;
}

- (UIBarButtonItem *)rightItem {
    if (!_rightItem) {
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    }
    return _rightItem;
}

- (UIBarButtonItem *)leftSpacer {
    if (!_leftSpacer) {
        _leftSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                   target:nil
                                                                   action:nil];
        _leftSpacer.width = -8.f;
    }
    return _leftSpacer;
}

- (UIBarButtonItem *)rightSpacer {
    if (!_rightSpacer) {
        _rightSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                    target:nil
                                                                    action:nil];
        _rightSpacer.width = 8.f;
    }
    return _rightSpacer;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
