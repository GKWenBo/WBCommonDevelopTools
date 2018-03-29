//
//  WB_EmotionButton.h
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBEmotionButton : UIButton
/*
 * 当前按钮对应的表情名字
 */
@property(nonatomic, copy) NSString *emotionName;
/*
 * 按钮的类型
 * 0是表情 1是删除
 */
@property(nonatomic, assign) NSUInteger btnType;
@end
