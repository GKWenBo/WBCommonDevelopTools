//
//  WB_MainScrollView.m
//  WB_PhotoBrowser
//
//  Created by Admin on 2017/7/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBMainScrollView.h"
#import "WBPhotoBrowserConfig.h"
#import "WBBrowserPhoto.h"
#import "WBOneScrollView.h"
@interface WBMainScrollView () <UIScrollViewDelegate,WBOneScrollViewDelegate>
{
    NSInteger willBeginDraggingIndex;
}
/** 存放了所有 单个滚动器 */
@property (strong, nonatomic) NSMutableArray *oneScrolArr;
@end
@implementation WBMainScrollView

- (void)dealloc {
    NSLog(@"%@销毁了",NSStringFromClass([self class]));
    self.delegate = nil;
}
#pragma mark -- 初始化
#pragma mark
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(-kGap, 0, SCREEN_WIDTH + kGap + kGap, SCREEN_HEIGHT);
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        if (@available(iOS 11,*)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

#pragma mark -- 展示数据
#pragma mark
- (void)setPhotoData:(NSArray *)photoArr type:(WBPhotoBrowserType)type {
    self.contentSize = CGSizeMake(photoArr.count * self.width, 0);
    NSInteger selecImageIndex = 0;
    for (NSInteger i = 0; i < photoArr.count; i ++) {
        WBBrowserPhoto *photo = photoArr[i];
        if (photo.isSelecImageView == YES) {
            selecImageIndex = i;
            break;
        }
    }
    self.contentOffset = CGPointMake(selecImageIndex * self.width,0);
    for (NSInteger i = 0; i < photoArr.count; i ++) {
        WBBrowserPhoto *photo = photoArr[i];
        WBOneScrollView *oneScroll = [[WBOneScrollView alloc]init];
        oneScroll.myDelegate = self;
        oneScroll.myindex = i;
        oneScroll.frame = CGRectMake(i * self.width + kGap, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubview:oneScroll];
        
        switch (type) {
            case WBPhotoBrowserLocalType:
                [oneScroll setLocalImage:photo.imageView];
                break;
            case WBPhotoBrowserNetWorkType:
                [oneScroll setNetWorkImage:photo.imageView urlStr:photo.urlStr];
                break;
            default:
                break;
        }
        [self.oneScrolArr addObject:oneScroll];
    }
}

#pragma mark -- UIScrollViewDelegate
#pragma mark
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger x = scrollView.contentOffset.x;
    NSInteger w = scrollView.bounds.size.width;
    NSInteger gapHead = (x % w);
    NSInteger mainW =   self.frame.size.width ;
    int gapEnd =  (int)mainW - (int)gapHead;
    //接近30个点 边距的时候会调用 用0的话有的时候不触发
    if(labs(gapHead) <= 20.0 ||abs(gapEnd) <= 20.0  )
    {
        //当前观看的这个是第几个oneSc
        NSInteger  nowLookIndex =( scrollView.contentOffset.x + (scrollView.bounds.size.width/2)) /scrollView.bounds.size.width  ;
        for(int i = 0;i < self.oneScrolArr.count ; i++  )
        {
            if (i != nowLookIndex) {//除了当前看的 其他都给我重置位置
                WBOneScrollView *one = self.oneScrolArr[i];
                [one reloadFrame];
            }else
            {
                
            }
        }
    }
}

#pragma mark -- WB_OneScrollViewDelegate
#pragma mark
- (void)willGoBack:(NSInteger)seletedIndex {
    self.delegate = nil;
    [self.myDelegate photoViwerWilldealloc:seletedIndex];
}

- (void)goBack {
    [self.superview removeFromSuperview];
}

#pragma mark -- Getter And Setter
#pragma mark
- (NSMutableArray *)oneScrolArr {
    if (!_oneScrolArr) {
        _oneScrolArr = @[].mutableCopy;
    }
    return _oneScrolArr;
}

@end
