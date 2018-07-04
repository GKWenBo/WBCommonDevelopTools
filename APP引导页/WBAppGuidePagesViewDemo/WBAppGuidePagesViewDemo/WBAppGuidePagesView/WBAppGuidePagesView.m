//
//  WBAppGuidePagesView.m
//  WBAppGuidePagesViewDemo
//
//  Created by wenbo on 2018/5/14.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "WBAppGuidePagesView.h"
#import <YYImage.h>

@interface WBAppGuidePagesView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray <NSString *>*imageArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation WBAppGuidePagesView

#pragma mark < 便利初始化 >
+ (instancetype)wb_pagesViewWithFrame:(CGRect)frame
                               images:(NSArray<NSString *> *)images {
    WBAppGuidePagesView *pageView = [[self alloc]initWithFrame:frame];
    pageView.imageArray = images;
    return pageView;
}

#pragma mark < init >
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self wb_commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self wb_commonInit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark < Private Method >
- (void)wb_commonInit {
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleRecognizer];
}

- (void)setupPageScrollView {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
    [self.imageArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(idx * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        YYImage *image = [YYImage imageNamed:obj];
        imageView.image = image;
        [self.scrollView addSubview:imageView];
    }];
    
}

#pragma mark < UIScrollViewDelegate >
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger currentPage = (offsetX / (self.bounds.size.width) + 0.5);
    self.pageControl.currentPage = currentPage;
    self.pageControl.hidden = (currentPage > self.imageArray.count - 1);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x >= self.imageArray.count * self.bounds.size.width) {
        [self removeFromSuperview];
    }
}

#pragma mark < Event Response >
- (void)handleSingleTapFrom {
    if (self.pageControl.currentPage == self.imageArray.count - 1) {
        [self removeFromSuperview];
    }
}

#pragma mark < Getter >
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2.f, [UIScreen mainScreen].bounds.size.height - 60, 0, 40)];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.numberOfPages = self.imageArray.count;
    }
    return _pageControl;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * (self.imageArray.count + 1), [UIScreen mainScreen].bounds.size.height);
    }
    return _scrollView;
}

#pragma mark < Setter >
- (void)setImageArray:(NSArray<NSString *> *)imageArray {
    _imageArray = imageArray;
    [self setupPageScrollView];
}
@end
