//
//  WB_NumberButton.h
//  WB_NumberButton
//
//  Created by WMB on 2017/6/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBNumberButton;

@protocol WBNumberButtonDelegate <NSObject>

@optional
- (void)wbNumberButton:(WBNumberButton *)wbNumberButton number:(NSString *)number;

@end

@interface WBNumberButton : UIView

/**  数量改变回调  */
@property (nonatomic,copy) void (^CountChangeBlock) (NSString * count);

@property (nonatomic,assign) id <WBNumberButtonDelegate> delegate;

/**  边框颜色  没设置则没有  */
@property (nonatomic,strong) UIColor * borderColor;

/**  赋值  */
@property (nonatomic,strong) NSString * number;

/**  字体大小  */
@property (nonatomic,strong) UIFont * font;

/**  是否开启抖动动画  */
@property (nonatomic,assign,getter=isShakeAnimation) BOOL shakeAnimation;

#pragma mark --------  设置按钮 注意：只能调用其中一个方法  --------
#pragma mark
/**
 *  设置加、减按钮标题
 *
 *  @param increaseTitle 加按钮标题
 *  @param decreaseTitle 减按钮标题
 */
- (void)wb_setIncreaseTitle:(NSString *)increaseTitle
              decreaseTitle:(NSString *)decreaseTitle;

/**
 *  设置加/减按钮的图片
 *
 *  @param increaseNormalImage 加按钮普通状态图片
 *  @param increaseHighlightImage 加按钮高亮状态图片
 *  @param decreaseNormalImage 减按钮普通状态图片
 *  @param decreaseHighlightImage 减按钮普通状态图片
 */
- (void)wb_setIncreaseNormalImage:(NSString *)increaseNormalImage
           increaseHighlightImage:(NSString *)increaseHighlightImage
              decreaseNormalImage:(NSString *)decreaseNormalImage
           decreaseHighlightImage:(NSString *)decreaseHighlightImage;

@end
