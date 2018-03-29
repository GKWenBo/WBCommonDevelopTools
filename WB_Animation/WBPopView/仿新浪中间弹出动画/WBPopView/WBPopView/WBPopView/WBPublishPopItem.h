//
//  WBItem.h
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBPublishPopItem : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *icon;

- (instancetype)initWithTitle:(NSString *)title
                         Icon:(NSString *)icon;

@end
