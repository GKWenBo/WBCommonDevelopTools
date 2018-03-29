//
//  WBPublishPopBtn.m
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import "WBPublishPopBtn.h"

@implementation WBPublishPopBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect rect = CGRectMake(0, (contentRect.size.height - ICONHEIGHT - TITLEHEIGHT) / 2, contentRect.size.width, ICONHEIGHT);
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(0, (contentRect.size.height - ICONHEIGHT - TITLEHEIGHT) / 2 + ICONHEIGHT, contentRect.size.width, TITLEHEIGHT);
    return rect;
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}

- (void)dealloc{
    NSLog(@"BHBCustomBtn");
}

@end
