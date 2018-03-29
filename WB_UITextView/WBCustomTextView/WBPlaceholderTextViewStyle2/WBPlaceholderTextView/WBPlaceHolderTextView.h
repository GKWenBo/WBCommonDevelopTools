//
//  WB_PlaceHolderTextView.h
//  WB_PlaceHolderTextView
//
//  Created by Admin on 2017/7/20.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface WBPlaceHolderTextView : UITextView

@property (nonatomic, copy) IBInspectable NSString *placeholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
@end
NS_ASSUME_NONNULL_END
