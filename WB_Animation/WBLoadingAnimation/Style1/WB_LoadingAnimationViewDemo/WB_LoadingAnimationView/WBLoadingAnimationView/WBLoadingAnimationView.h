//
//  WB_LoadingAnimationView.h
//  WB_LoadingAnimationView
//
//  Created by WMB on 2017/9/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBLoadingAnimationView : UIView

+ (WBLoadingAnimationView *)wb_showLoadingViewWith:(UIView *)view;
+ (WBLoadingAnimationView *)wb_showLoadingViewWithWindow;

- (void)wb_hideLoadingView;

@end
