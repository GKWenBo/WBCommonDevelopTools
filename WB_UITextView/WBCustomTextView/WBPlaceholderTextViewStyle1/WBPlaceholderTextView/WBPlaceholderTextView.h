//
//  WB_PlaceHolderTextView.h
//  WB_PlaceHolderTextView
//
//  Created by WMB on 2017/5/31.
//  Copyright © 2017年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBPlaceholderTextView : UITextView

/**  占位符  */
@property (nonatomic,strong) IBInspectable NSString * placeholder;
/**  占位符颜色  */
@property (nonatomic,strong) IBInspectable UIColor * placehoderColor;

- (void)textChanged:(NSNotification*)notification;

@end
