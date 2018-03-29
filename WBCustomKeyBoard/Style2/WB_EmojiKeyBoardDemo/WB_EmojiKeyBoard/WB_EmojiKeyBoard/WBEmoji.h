//
//  WBEmoji.h
//  WB_EmojiKeyBoard
//
//  Created by WMB on 2017/9/17.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WB_EmojiType) {
    // emoji show type
    WB_EmojiTypePeople = 0,
    WB_EmojiTypeFlower,
    WB_EmojiTypeBell,
    WB_EmojiTypeVehicle,
    WB_EmojiTypeNumber,
};
@interface WBEmoji : NSObject

@property (assign, nonatomic) WB_EmojiType type;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *emojis;

@end


@interface WBEmoji (Generate)
+ (NSArray *)allEmojis;
@end
