//
//  MRZoomScrollView.m
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import "MRZoomScrollView.h"

#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].bounds)
#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].bounds)

@interface MRZoomScrollView (Utility)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation MRZoomScrollView

@synthesize imageView,MRdelegate=_MRdelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
        
        [self initImageView];
    }
    return self;
}

- (void)initImageView
{
    imageView = [[UIImageView alloc]init];
    
    // The imageView can be zoomed largest size
    imageView.frame = CGRectMake(0, 0, MRScreenWidth * 2.5, MRScreenHeight * 2.5);
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    // Add gesture,double tap zoom imageView.
     self.doubleTapGesture= [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleDoubleTap:)];
    [self.doubleTapGesture setNumberOfTapsRequired:2];
    self.doubleTapGesture.numberOfTouchesRequired=1;
    [imageView addGestureRecognizer:self.doubleTapGesture];
    
    
    UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoColse:)];
    tapClose.numberOfTapsRequired=1;
    tapClose.numberOfTouchesRequired = 1;
    [tapClose requireGestureRecognizerToFail:self.doubleTapGesture];
    [imageView addGestureRecognizer:tapClose];
    
    float minimumScale = self.frame.size.width / imageView.frame.size.width;
    [self setMinimumZoomScale:minimumScale];
    [self setZoomScale:minimumScale];
}

- (void)photoColse:(UITapGestureRecognizer *)tap
{
    if ([_MRdelegate respondsToSelector:@selector(closeView:)])
    {
        [_MRdelegate closeView:tap];
    }
}

#pragma mark - Zoom methods

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
{
    float newScale = self.zoomScale * 1.5;
    
    
    CGRect zoomRect;
    if (newScale<=0.9) {
        zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
    }else
    {
       zoomRect = [self zoomRectForScale:0.4 withCenter:[gesture locationInView:gesture.view]];
    }
    
     [self zoomToRect:zoomRect animated:YES];
   
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark - View cycle
- (void)dealloc
{
    
}

@end
