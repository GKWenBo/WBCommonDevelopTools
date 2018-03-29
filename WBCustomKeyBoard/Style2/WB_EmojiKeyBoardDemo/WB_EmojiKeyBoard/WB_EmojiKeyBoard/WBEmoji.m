//
//  WB_Emoji.m
//  WB_EmojiKeyBoard
//
//  Created by WMB on 2017/9/17.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBEmoji.h"

@implementation WBEmoji

@end


@implementation WBEmoji (Generate)

+ (NSDictionary *)emojis{
    static NSDictionary *__emojis = nil;
    if (!__emojis){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"json"];
        NSData *emojiData = [[NSData alloc] initWithContentsOfFile:path];
        __emojis = [NSJSONSerialization JSONObjectWithData:emojiData options:NSJSONReadingAllowFragments error:nil];
    }
    return __emojis;
}

+ (instancetype)peopleEmoji{
    WBEmoji *emoji = [WBEmoji new];
    emoji.title = @"人物";
    emoji.emojis = [self emojis][@"people"];
    emoji.type = WB_EmojiTypePeople;
    return emoji;
}

+ (instancetype)flowerEmoji{
    WBEmoji *emoji = [WBEmoji new];
    emoji.title = @"自然";
    emoji.emojis = [self emojis][@"flower"];
    emoji.type = WB_EmojiTypeFlower;
    return emoji;
}

+ (instancetype)bellEmoji{
    WBEmoji *emoji = [WBEmoji new];
    emoji.title = @"日常";
    emoji.emojis = [self emojis][@"bell"];
    emoji.type = WB_EmojiTypeBell;
    return emoji;
}

+ (instancetype)vehicleEmoji{
    WBEmoji *emoji = [WBEmoji new];
    emoji.title = @"建筑与交通";
    emoji.emojis = [self emojis][@"vehicle"];
    emoji.type = WB_EmojiTypeVehicle;
    return emoji;
}

+ (instancetype)numberEmoji{
    WBEmoji *emoji = [WBEmoji new];
    emoji.title = @"符号";
    emoji.emojis = [self emojis][@"number"];
    emoji.type = WB_EmojiTypeNumber;
    return emoji;
}

+ (NSArray *)allEmojis{
    return @[[self peopleEmoji], [self flowerEmoji], [self bellEmoji], [self vehicleEmoji], [self numberEmoji]];
}

@end
