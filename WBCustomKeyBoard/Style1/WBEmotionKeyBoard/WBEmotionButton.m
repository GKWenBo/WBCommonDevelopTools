//
//  WB_EmotionButton.m
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBEmotionButton.h"

@implementation WBEmotionButton

- (void)setEmotionName:(NSString *)emotionName {
    
    _emotionName = emotionName;
    UIImage *image = [UIImage imageNamed:emotionName];
    if (image) {[self setImage:image forState:UIControlStateNormal];}
    self.userInteractionEnabled = image == nil ? NO : YES;
}

@end
