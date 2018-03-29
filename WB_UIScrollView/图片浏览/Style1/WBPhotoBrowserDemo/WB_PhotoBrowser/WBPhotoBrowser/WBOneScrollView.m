//
//  WB_OneScrollView.m
//  WB_PhotoBrowser
//
//  Created by Admin on 2017/7/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBOneScrollView.h"
#import "WBPhotoBrowserConfig.h"
@interface WBOneScrollView () <UIScrollViewDelegate>
{
    BOOL _isdoubleTap;/** 记录是否是双击放大,还是单机返回 的一个动作判断参数 */
    SDDemoItemView * progressItemView;
}
/** 每个滚动控制器自带一个核心相片 */
@property(nonatomic, weak)UIImageView *mainImageView;
/** 双击动作,在下载完图片后才会有双击手势动作 */
@property(nonatomic,strong)UITapGestureRecognizer *twoTap;
/** 点击时返回退出 */
@property (nonatomic, strong) UITapGestureRecognizer *tap;
/** 返回去的位置 */
@property(nonatomic, weak)UIImageView *originalImageView;
@end
@implementation WBOneScrollView

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
        self.userInteractionEnabled = NO;
        self.delegate = self;
        UIImageView *mainImageView = [UIImageView new];
        mainImageView.userInteractionEnabled = YES;
        [self addSubview:mainImageView];
        self.mainImageView = mainImageView;
        [self addGestureRecognizer:self.tap];
        if (@available(iOS 11,*)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

#pragma mark -- 加载本地图片
#pragma mark
- (void)setLocalImage:(UIImageView *)imageView {
    self.originalImageView = imageView;
    CGRect originalRect = [imageView convertRect:imageView.bounds toView:kDelegateWindow];
    self.mainImageView.frame = originalRect;
    /** 动画变换设置frame */
    [UIView animateWithDuration:kAnimationInterval delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
        [self setFrameAndZoom:imageView];
        self.superview.backgroundColor = [UIColor blackColor];
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:self.twoTap];
    }];
}

#pragma mark -- 加载网络图片
#pragma mark
- (void)setNetWorkImage:(UIImageView *)imageView urlStr:(NSString *)urlStr {
    self.originalImageView = imageView;
    CGRect originalRect = [imageView convertRect:imageView.bounds toView:kDelegateWindow];
    self.mainImageView.frame = originalRect;
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.mainImageView.clipsToBounds = YES;
    /** 动画变换设置frame与背景颜色 */
    [UIView animateWithDuration:kAnimationInterval delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
        [self setFrameAndZoom:imageView];
        self.maximumZoomScale =1;
        self.minimumZoomScale =1;
        self.superview.backgroundColor = [UIColor blackColor];
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES ;
        //变换完动画 从网络开始加载图
        [self.mainImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:self.mainImageView.image options:SDWebImageRetryFailed | SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            NSLog(@"%ld  :  %ld",(long)receivedSize,(long)expectedSize);
            if (expectedSize > 0) {
                CGFloat progress = (float)receivedSize / expectedSize;
                [self performSelectorOnMainThread:@selector(changeProgressWithProgress:) withObject:[NSNumber numberWithFloat:progress] waitUntilDone:NO];
            }
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error == nil) {
                [self addGestureRecognizer:self.twoTap];
                self.mainImageView.image = image;
                [self setFrameAndZoom:self.mainImageView];
            }else {
                
            }
        }];
    }];
}

#pragma mark -- 改变进度条
#pragma mark
- (void)changeProgressWithProgress:(NSNumber*)progress {
    if (!progressItemView) {
        progressItemView = [SDDemoItemView demoItemViewWithClass:[SDLoopProgressView class]];
        progressItemView.frame = CGRectMake(0, 0, 80 , 80);
        progressItemView.center = self.mainImageView.center;
        [self addSubview:progressItemView];
    }
    progressItemView.progressView.progress = [progress floatValue];
}

#pragma mark -- 计算Frame核心代码
#pragma mark
- (void)setFrameAndZoom:(UIImageView *)imageView {
    //imageView.image
    CGFloat imageH;
    CGFloat imageW;
    //设置空image时的情况
    if (imageView.image == nil || imageView.image.size.width == 0 || imageView.image.size.height == 0) {
        //设置主图片
        imageH = SCREEN_HEIGHT;
        imageW = SCREEN_WIDTH;
        self.mainImageView.image = [UIImage imageNamed:@"none"];
    }else {//不空
        //设置主图片
        imageW = imageView.image.size.width;
        imageH = imageView.image.size.height;
        self.mainImageView.image = imageView.image;
    }
    //设置主图片Frame与缩小比例
    if (imageW >= (imageH * (SCREEN_WIDTH / SCREEN_HEIGHT))) {//横着
        //设置居中frme
        CGFloat myX_ = 0;
        CGFloat myW_ = SCREEN_WIDTH;
        CGFloat myH_ = myW_ * (imageH / imageW);
        CGFloat myY_ = SCREEN_HEIGHT - myH_ - ((SCREEN_HEIGHT - myH_) / 2);
        self.mainImageView.frame = CGRectMake(myX_, myY_, myW_, myH_);
        //判断原图是小图还是大图来判断,是可以缩放,还是可以放大
        if (imageW > myW_) {
            self.maximumZoomScale = 2 * (imageW / myW_);//放大比例
        }else {
            self.minimumZoomScale = (imageW / myW_);//缩放比例
        }
    }else {//竖着
        CGFloat  myH_ = SCREEN_HEIGHT;
        CGFloat  myW_ = myH_ *(imageW/imageH);
        CGFloat  myX_ = SCREEN_WIDTH - myW_ - ((SCREEN_WIDTH - myW_)/2);
        CGFloat  myY_ = 0;
        //变换设置frame
        self.mainImageView.frame = CGRectMake(myX_, myY_, myW_, myH_);
        //判断原图是小图还是大图来判断,是可以缩放,还是可以放大
        if (imageH >  myH_) {
            self.maximumZoomScale =  2*(imageH/myH_ ) ;//放大比例
        }else
        {
            self.minimumZoomScale = (imageH/myH_);//缩小比例
        }
    }
}

#pragma mark -- Event Response
#pragma mark
- (void)goBack:(UITapGestureRecognizer *)tap {
    _isdoubleTap = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(_isdoubleTap)return ;
        if (_myDelegate && [_myDelegate respondsToSelector:@selector(willGoBack:)]) {
            [_myDelegate willGoBack:self.myindex];
        }
        CGRect newOriginalRect = [self.originalImageView convertRect:self.originalImageView.bounds toView:kDelegateWindow];
        self.userInteractionEnabled = NO;
        self.zoomScale = 1.f;
        self.delegate = nil;
        [UIView animateWithDuration:kAnimationInterval delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
            self.mainImageView.frame = newOriginalRect;
            self.superview.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            if (_myDelegate && [_myDelegate respondsToSelector:@selector(goBack)]) {
                [_myDelegate goBack];
            }
        }];
    });
}

- (void)beginZoom:(UITapGestureRecognizer*)tap {
    _isdoubleTap = YES;
    CGPoint touchPoint = [tap locationInView:self.mainImageView];
    if (self.zoomScale == self.maximumZoomScale) {
        [self setZoomScale:1.0 animated:YES];
    }else {
        CGRect zoomRect;
        zoomRect.origin.x = touchPoint.x;
        zoomRect.origin.y = touchPoint.y;
        [self zoomToRect:zoomRect animated:YES];
    }
}

#pragma mark -- UIScrollViewDelegate
#pragma mark
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.mainImageView;
}

/** 缩放时调用 ,确定中心点代理方法 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGSize scrollSize = scrollView.bounds.size;
    CGRect imgViewFrame = self.mainImageView.frame;
    CGSize contentSize = scrollView.contentSize;
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    // 竖着长的 就是垂直居中
    if (imgViewFrame.size.width <= scrollSize.width)
    {
        centerPoint.x = scrollSize.width / 2;
    }
    // 横着长的  就是水平居中
    if (imgViewFrame.size.height <= scrollSize.height)
    {
        centerPoint.y = scrollSize.height / 2;
    }
    self.mainImageView.center = centerPoint;
}

#pragma mark -- 恢复原状
#pragma mark
- (void)reloadFrame {
    self.zoomScale = 1.f;
}

#pragma mark -- Getter And Setter
#pragma mark
- (UITapGestureRecognizer *)twoTap {
    if (!_twoTap) {
        _twoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(beginZoom:)];
        _twoTap.numberOfTapsRequired = 2;
    }
    return _twoTap;
}

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBack:)];
        _tap.numberOfTapsRequired = 1;
    }
    return _tap;
}

@end
