//
//  WBZoomView.m
//  WBZoomViewDemo
//
//  Created by Admin on 2017/11/1.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBZoomView.h"

@interface WBZoomView () <UIScrollViewDelegate>

#pragma mark ------ < Property > ------
#pragma mark
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation WBZoomView

#pragma mark ------ < 初始化 > ------
#pragma mark
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark ------ < 设置UI > ------
#pragma mark
- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
}

#pragma mark ------ < Evnet Response > ------
#pragma mark
- (void)doubleTap:(UITapGestureRecognizer *)recognizer {
    
}

#pragma mark ------ < UIScrollViewDelegate > ------
#pragma mark
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGSize originalSize = _scrollView.bounds.size;
    CGSize contentSize = _scrollView.contentSize;
    CGFloat offsetX = originalSize.width > contentSize.width ? (originalSize.width - contentSize.width) / 2 : 0;
    CGFloat offsetY = originalSize.height > contentSize.height ? (originalSize.height - contentSize.height) / 2 : 0;
    self.imageView.center = CGPointMake(contentSize.width / 2 + offsetX, contentSize.height / 2 + offsetY);
}

#pragma mark ------ < Getter > ------
#pragma mark
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [_imageView addGestureRecognizer:doubleTap];
    }
    return _imageView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 5.f;
        _scrollView.minimumZoomScale = 1.f;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.bouncesZoom = YES;
        _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    }
    return _scrollView;
}

#pragma mark ------ < Setter > ------
#pragma mark
- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat maxHeight = self.scrollView.bounds.size.height;
    CGFloat maxWidth = self.scrollView.bounds.size.width;
    //如果图片尺寸大于view尺寸，按比例缩放
    if(width > maxWidth || height > width){
        CGFloat ratio = height / width;
        CGFloat maxRatio = maxHeight / maxWidth;
        if(ratio < maxRatio){
            width = maxWidth;
            height = width*ratio;
        }else{
            height = maxHeight;
            width = height / ratio;
        }
    }
    self.imageView.frame = CGRectMake((maxWidth - width) / 2, (maxHeight - height) / 2, width, height);
}

@end
