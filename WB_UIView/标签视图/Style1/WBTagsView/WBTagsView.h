//
//  WB_TagsView.h
//  WB_TagsView
//
//  Created by WMB on 2017/9/10.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTagsView;
@protocol WB_TagsViewDelegate <NSObject>

@optional;
- (void)wb_tagsView:(WBTagsView *)wb_tagsView didSelectedIndex:(NSInteger)index;

- (void)wb_tagsView:(WBTagsView *)wb_tagsView didDeselectedIndex:(NSInteger)index;

@end

@interface WBTagsView : UIView

/**
 tag contentInset default(10,10,10 10)
 */
@property (nonatomic,assign) UIEdgeInsets contentInset;

/**
 top、left Margin default 10
 */
@property (nonatomic,assign) CGFloat tagMargin;
/**
 tag dataSource
 */
@property (nonatomic,strong) NSArray <NSString *>* tagsArray;

/**
 tag width default 0
 */
@property (nonatomic,assign) CGFloat borderWidth;

/**
 colorRadius default 0
 */
@property (nonatomic,assign) CGFloat cornerRadius;

/**
 tag fontSize default 14pt
 */
@property (nonatomic,strong) UIFont * tagFont;

/**
 tag title color default darkGrayColor
 */
@property (nonatomic,strong) UIColor * tagTitleColor;

/**
 border normalColor default nil
 */
@property (nonatomic,strong) UIColor * borderNormalColor;

/**
 border selectedColor default nil
 */
@property (nonatomic,strong) UIColor * borderSelectedColor;

/**
 normal backgroundImage default white color
 */
@property (nonatomic,strong) UIImage * tagNormalBackgroundImage;

/**
 selected backgroundImage default white color
 */
@property (nonatomic,strong) UIImage * tagSelectedBackgroundImage;

/**
 allow selected default NO
 */
@property (nonatomic,assign) BOOL allowSelected;

/**
 allow SingleSelected default NO
 */
@property (nonatomic,assign) BOOL allowSingleSelected;

/**
 allow MultipleSelected default NO
 */
@property (nonatomic,assign) BOOL allMultipleSelected;

/**
 allow selected idx one
 */
@property (nonatomic,assign) BOOL allowDefalutSelected;

/**
 选中数据
 */
@property (nonatomic,strong,readonly) NSArray <NSString *>* didSelectedTags;

/**
 default selected buttonTitle
 */
@property (nonatomic,strong) NSArray <NSString *>* defualtSelectedTitleArray;

/**
 default selected index
 */
@property (nonatomic,strong) NSArray <NSNumber *>* defaultSelectedIndexArray;


/**
 tagsView height
 */
@property (nonatomic,assign,readonly) CGFloat tagsViewHeight;

@property (nonatomic,assign) id <WB_TagsViewDelegate> delegate;

#pragma mark --------  regular tagsView  --------
#pragma mark
/**
 tag number of Column defualt 0
 */
@property (nonatomic,assign) NSInteger tagsColumn;

@end


@interface NSString (WB_CalculateSize)
/**
 *  计算文字size
 *
 *  @param size 限制size
 *  @param font 字体
 *  @return 文字size
 */

- (CGSize)wb_sizeForFont:(UIFont *)font
                    size:(CGSize)size
                    mode:(NSLineBreakMode)lineBreakMode;

@end
