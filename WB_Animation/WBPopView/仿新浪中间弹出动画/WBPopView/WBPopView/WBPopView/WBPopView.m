//
//  WBPopView.m
//  WBPopView
//
//  Created by Admin on 2018/1/19.
//  Copyright © 2018年 WENBO. All rights reserved.
//

#import "WBPublishPopView.h"

@interface WBPublishPopView ()

@property (nonatomic,copy) WBDidSelectedBlock selectedBlock;
@property (nonatomic,strong) NSArray *items;
@end

@implementation WBPublishPopView

+ (instancetype)wb_showToView:(UIView *)view andImages:(NSArray *)imageArray andTitles:(NSArray *)titles andSelectBlock:(WBDidSelectedBlock)block {
    NSMutableArray *items = @[].mutableCopy;
    for (NSInteger index = 0; index < imageArray.count; index ++) {
        WBItem *item = [[WBItem alloc]initWithTitle:titles[index] Icon:imageArray[index]];
        [items addObject:item];
    }
    [self viewNotEmpty:view];
    WBPublishPopView *popView = [[WBPublishPopView alloc]initWithFrame:view.bounds];
    popView.selectedBlock = block;
    popView.items = items;
    
    return popView;
}

+ (void)viewNotEmpty:(UIView *)view{
    if (view == nil) {
        view = (UIView *)[[UIApplication sharedApplication] delegate];
    }
    
}

@end
