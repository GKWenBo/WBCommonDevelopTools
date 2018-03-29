//
//  WB_CountdownButton.h
//  WB_CountdownButton
//
//  Created by WMB on 2017/6/9.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface WBCountdownButton : UIButton

/**  任务标示  */
@property (nonatomic,copy) IBInspectable NSString * identifyKey;

/**  倒计时背景色  */
@property (nonatomic,strong) IBInspectable UIColor * disabledBackgroundColor;

/**  倒计时标题颜色  */
@property (nonatomic, strong) IBInspectable UIColor *disabledTitleColor;

/**  倒计时时间 默认60秒  注意：不能超过180秒  */
@property (nonatomic,assign) CGFloat countDownTime;

/**  开始倒计时  */
- (void)wb_timeFire;

@end
