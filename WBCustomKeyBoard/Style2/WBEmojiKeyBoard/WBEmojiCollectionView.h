//
//  WB_EmojiCollectionView.h
//  WB_EmojiKeyBoard
//
//  Created by WMB on 2017/9/17.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WBEmojiCollectionViewDelegate <NSObject>

@required
- (NSInteger)countOfEmojiPageSection;
- (NSArray *)emojisForSection:(NSInteger)section;
- (NSString *)titleForSection:(NSInteger)section;

@optional
- (void)emojiDidClicked:(NSString *)emoji;
- (void)didScrollToSection:(NSInteger)section;

@end

@interface WBEmojiCollectionView : UIScrollView

@property (nonatomic,assign) id <WBEmojiCollectionViewDelegate> emojiDelegate;

- (void)reloadData;
- (void)showSection:(NSInteger)section;


@end
