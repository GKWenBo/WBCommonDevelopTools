//
//  WBZoomingImageViewController.h
//  WBImageZoomingDemo
//
//  Created by WMB on 2017/10/31.
//  Copyright © 2017年 WMB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBZoomingImageViewController : UIViewController <UIScrollViewDelegate>

{
    UIScrollView *imageScrollView;
    UIImageView * imageView;
}

/**
 To scale the image
 */
@property (nonatomic,strong) UIImage * zoomImage;
/**
 Image network
 */
- (void)loadImageData;



@end
