//
//  MRZoomScrollView.h
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MRZoomScrollViewDelegate <NSObject>

-(void)closeView:(UITapGestureRecognizer *)tap;

@end

@interface MRZoomScrollView : UIScrollView <UIScrollViewDelegate>
{
    UIImageView *imageView;
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;

@property(nonatomic, weak)id<MRZoomScrollViewDelegate>MRdelegate;


@end
