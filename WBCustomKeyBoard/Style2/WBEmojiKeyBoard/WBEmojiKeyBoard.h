//
//  WB_EmojiKeyBoard.h
//  WB_EmojiKeyBoard
//
//  Created by WMB on 2017/9/17.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBEmojiKeyBoard : UIView <UIInputViewAudioFeedback>
+ (instancetype)keyboard;
@property (strong, nonatomic) id<UITextInput> textView;
@end
