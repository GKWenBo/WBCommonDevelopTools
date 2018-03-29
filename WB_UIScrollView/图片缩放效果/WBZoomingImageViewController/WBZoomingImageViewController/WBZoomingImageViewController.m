//
//  WBZoomingImageViewController.m
//  WBImageZoomingDemo
//
//  Created by WMB on 2017/10/31.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import "WBZoomingImageViewController.h"

#define ZOOM_STEP 2.0
@interface WBZoomingImageViewController ()
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
@end

@implementation WBZoomingImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadImageData];
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------ < 设置子视图 > ------
#pragma mark
- (void)setupSubViews {
    //Setting up the scrollView
    imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44 - [UIApplication sharedApplication].statusBarFrame.size.height)];
    imageScrollView.backgroundColor = [UIColor blackColor];
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.bouncesZoom = YES;
    imageScrollView.delegate = self;
    imageScrollView.clipsToBounds = YES;
    [self.view addSubview:imageScrollView];
    
    //Setting up the imageView
    imageView = [[UIImageView alloc] initWithImage:self.zoomImage];
    imageView.userInteractionEnabled = YES;
    imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
    
    //Adding the imageView to the scrollView as subView
    [imageScrollView addSubview:imageView];
    imageScrollView.contentSize = CGSizeMake(imageView.bounds.size.width, imageView.bounds.size.height);
    imageScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    //UITapGestureRecognizer set up
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    [doubleTap setNumberOfTapsRequired:2];
    [twoFingerTap setNumberOfTouchesRequired:2];
    
    //Adding gesture recognizer
    [imageView addGestureRecognizer:doubleTap];
    [imageView addGestureRecognizer:twoFingerTap];
    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = 1.0;//This is the minimum scale, set it to whatever you want. 1.0 = default
    imageScrollView.maximumZoomScale = 4.0;
    imageScrollView.minimumZoomScale = minimumScale;
    imageScrollView.zoomScale = minimumScale;
    [imageScrollView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView sizeToFit];
    [imageScrollView setContentSize:CGSizeMake(imageView.frame.size.width, imageView.frame.size.height)];
}

#pragma mark ------ < NetWork > ------
#pragma mark
- (void)loadImageData {
    
}

#pragma mark ------ < Private Method > ------
#pragma mark
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [imageScrollView frame].size.height / scale;
    zoomRect.size.width  = [imageScrollView frame].size.width  / scale;
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

#pragma mark ------ < UIScrollViewDelegate > ------
#pragma mark
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)aScrollView {
    CGFloat offsetX = (imageScrollView.bounds.size.width > imageScrollView.contentSize.width)?
    (imageScrollView.bounds.size.width - imageScrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (imageScrollView.bounds.size.height > imageScrollView.contentSize.height)?
    (imageScrollView.bounds.size.height - imageScrollView.contentSize.height) * 0.5 : 0.0;
    imageView.center = CGPointMake(imageScrollView.contentSize.width * 0.5 + offsetX,
                                   imageScrollView.contentSize.height * 0.5 + offsetY);
}

#pragma mark ------ < Event Response > ------
#pragma mark
- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    // two-finger tap zooms out
    float newScale = [imageScrollView zoomScale] / ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [imageScrollView zoomToRect:zoomRect animated:YES];
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // zoom in
    float newScale = [imageScrollView zoomScale] * ZOOM_STEP;
    if (newScale > imageScrollView.maximumZoomScale){
        newScale = imageScrollView.minimumZoomScale;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [imageScrollView zoomToRect:zoomRect animated:YES];
    }
    else{
        newScale = imageScrollView.maximumZoomScale;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [imageScrollView zoomToRect:zoomRect animated:YES];
    }
}

@end
