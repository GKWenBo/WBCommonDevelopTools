//
//  WB_EmotionPageView.m
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBEmotionPageView.h"
#import "WBEmotionKeyBoardConfigHeader.h"

@implementation WBEmotionPageView

#pragma mark --------  setter  --------
#pragma mark
- (void)setPage:(NSUInteger)page {
    _page = page;
    self.backgroundColor = [UIColor whiteColor];
    [self addEmotionButtons];
}

#pragma mark --------  add emotions  --------
#pragma mark
- (void)addEmotionButtons {
    int row = 1;
    CGFloat space = (SCREEN_WIDTH - KrowCount * emotionW) / (KrowCount + 1);
    for (int i = 0; i < emojiCount; i ++) {
        
        row = i / KrowCount + 1;
        WBEmotionButton *btn = [[WBEmotionButton alloc]init];
        btn.frame = CGRectMake((1 + i - (KrowCount * (row - 1))) * space + (i - (KrowCount * (row - 1))) * emotionW, space * row + (row - 1) * emotionW, emotionW, emotionW);
        btn.btnType = (i == emojiCount - 1) ? 1 : 0;
        if (i == emojiCount - 1) {
            btn.emotionName = @"expression_delete";
            btn.wb_size = CGSizeMake(emotionW + space, emotionW + space);
            CGFloat X = btn.wb_left;
            CGFloat Y = btn.wb_top;
            btn.wb_left = X - space / 3;
            btn.wb_top = Y - space / 3;
            [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            btn.emotionName = [NSString stringWithFormat:@"%lu",i + 1 + 20 * self.page];
            [btn addTarget:self action:@selector(emotionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:btn];
    }
}

//删除按钮事件
- (void)deleteBtnClick:(WBEmotionButton *)deleteButton {
    if (self.deleteButtonClick) {
        self.deleteButtonClick(deleteButton);
    }
}

//表情事件
- (void)emotionButtonClick:(WBEmotionButton *)emotionButton {
    if (self.emotionButtonClick) {
        self.emotionButtonClick(emotionButton);
    }
}

@end
