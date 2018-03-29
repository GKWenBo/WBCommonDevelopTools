//
//  WB_EmotionKeyBoardConfigHeader.h
//  DaShenLianMeng
//
//  Created by WMB on 2017/9/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#ifndef WB_EmotionKeyBoardConfigHeader_h
#define WB_EmotionKeyBoardConfigHeader_h

/*topbar*/
//输入框的高度
static CGFloat const TextViewH = 36.5;
//键盘切换按钮的宽度
static CGFloat const emotionBtnW = 36.5;
//键盘切换按钮的高度
static CGFloat const emotionBtnH = 36.5;
//顶部工具条的高度
#define topBarH   TextViewH - 10
//输入框的宽度
#define TextViewW SCREEN_WIDTH - 103

/*keyBoard*/
//键盘变化时间
static CGFloat const keyBoardTipTime = 0.3;
//每一页的按钮数，包括删除按钮
static CGFloat const emojiCount = 21;
//每一行的按钮数
static CGFloat const KrowCount = 7;
//每一页的行数
static CGFloat const rows = 3;

//键盘高度
#define keyBoardH (4 * SCREEN_WIDTH * 0.0875 +(3 + 1) * ((SCREEN_WIDTH - 7 * SCREEN_WIDTH * 0.0875 ) / 8) + 20)
//表情按钮宽高
#define emotionW SCREEN_WIDTH * 0.0875
//表情页的高度（第一键盘高度）
#define pageH (SCREEN_WIDTH - KrowCount * emotionW) / (KrowCount + 1)

#endif /* WB_EmotionKeyBoardConfigHeader_h */
