//
//  WB_BasePopupView.h
//  WB_PopupView1
//
//  Created by WMB on 2017/6/12.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WBShowHUDPositionStyle) {
    WBShowHUDPositionStyleDefault,       /**  缩放  */
    WBShowHUDPositionStyleTop,           /**  上  */
    WBShowHUDPositionStyleLeft,          /**  左  */
    WBShowHUDPositionStyleRight,         /**  右  */
    WBShowHUDPositionStyleBottom         /**  下  */
};

NS_ASSUME_NONNULL_BEGIN
@interface WBBasePopupView : UIView

/**  容器视图  */
@property (nonatomic,strong) UIView * contentView;
/**  圆角大小 默认6.f */
@property (nonatomic,assign) CGFloat cornerRadius;
/**  内容大小 默认：width：275 height：200 */
@property (nonatomic,assign) CGSize contentSize;
/**  动画样式  */
@property (nonatomic,assign) WBShowHUDPositionStyle animationStyle;

#pragma mark --------  设置视图  --------
#pragma mark
- (void)configDefautUI;
- (void)configUI;

#pragma mark --------  动画方法  --------
#pragma mark
/**  显示动画  */
- (void)wb_showHUDAnimation;
/**  隐藏动画  */
- (void)wb_hideHUDAnimation;

@end
NS_ASSUME_NONNULL_END
