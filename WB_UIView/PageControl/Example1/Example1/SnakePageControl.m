//
//  SnakePageControl.m
//  Example1
//
//  Created by WenBo on 2019/9/23.
//  Copyright © 2019 wenbo. All rights reserved.
//

#import "SnakePageControl.h"

@interface SnakePageControl ()

@property (nonatomic, strong) NSMutableArray <CALayer *>*inactiveLayers;
@property (nonatomic, strong) CALayer *activeLayer;

@end

@implementation SnakePageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (void)defaultConfig {
    _pageCount = 0;
    _progress = 0;
    _activeTint = [UIColor whiteColor];
    _inactiveTint = [UIColor colorWithWhite:1.f alpha:0.3];
    _indicatorPadding = 10;
    _indicatorRadius = 5.f;
    _indicatorDiameter = _indicatorRadius * 2;
}

// MARK: - State Update
- (void)updateNumberOfPages:(NSInteger)count {
    if (count == self.inactiveLayers.count) return;
    
    for (CALayer *layer in self.inactiveLayers) {
        [layer removeFromSuperlayer];
    }
    [self.inactiveLayers removeAllObjects];
    
    for (NSInteger i = 0; i < count; i ++) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = self.inactiveTint.CGColor;
        
        [self.layer addSublayer:layer];
        [self.inactiveLayers addObject:layer];
    }
    
    [self layoutInactivePageIndicators:self.inactiveLayers];
    [self.layer addSublayer:self.activeLayer];
    
    [self layoutActivePageIndicator:self.progress];
    [self invalidateIntrinsicContentSize];
}

- (void)layoutActivePageIndicator:(CGFloat)progress {
    if (progress < 0 || progress > self.pageCount - 1) return;
    CGFloat denormalizedProgress = progress * (self.indicatorDiameter + self.indicatorPadding);
    CGFloat distanceFromPage = ABS(round(progress) - progress);
    CGFloat width = self.indicatorDiameter + self.indicatorPadding * (distanceFromPage * 2);
    CGRect newFrame = CGRectMake(0, self.activeLayer.frame.origin.y, width, self.indicatorDiameter);
    newFrame.origin.x = denormalizedProgress;
    self.activeLayer.cornerRadius = self.indicatorRadius;
    self.activeLayer.frame = newFrame;
}



- (void)layoutInactivePageIndicators:(NSMutableArray *)layers {
    CGRect layerFrame = CGRectMake(0, 0, self.indicatorDiameter, self.indicatorDiameter);
    for (CALayer *layer in layers) {
        layer.cornerRadius = self.indicatorRadius;
        layer.frame = layerFrame;
        layerFrame.origin.x += self.indicatorDiameter + self.indicatorPadding;
    }
}

// MARK:getter
- (CALayer *)activeLayer {
    if (!_activeLayer) {
        _activeLayer = [CALayer layer];
        _activeLayer.backgroundColor = self.activeTint.CGColor;
        _activeLayer.cornerRadius = self.indicatorRadius;
        _activeLayer.frame = CGRectMake(0, 0, self.indicatorDiameter, self.indicatorDiameter);
    }
    return _activeLayer;
}

- (NSMutableArray<CALayer *> *)inactiveLayers {
    if (!_inactiveLayers) {
        _inactiveLayers = @[].mutableCopy;
    }
    return _inactiveLayers;
}

- (CGSize)intrinsicContentSize {
    return [self sizeThatFits:CGSizeZero];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(self.inactiveLayers.count * self.indicatorDiameter + (self.inactiveLayers.count - 1) * self.indicatorPadding, self.indicatorDiameter);
}

// MARK:setter
- (void)setPageCount:(NSInteger)pageCount {
    if (pageCount <= 0) return;
    _pageCount = pageCount;
    
    [self updateNumberOfPages:pageCount];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    [self layoutActivePageIndicator:progress];
}

- (NSInteger)currentPage {
    return (NSInteger)round(self.progress);
}

- (void)setActiveTint:(UIColor *)activeTint {
    _activeTint = activeTint;
    
    self.activeLayer.backgroundColor = activeTint.CGColor;
}

- (void)setInactiveTint:(UIColor *)inactiveTint {
    _inactiveTint = inactiveTint;
    
    for (CALayer *layer in self.inactiveLayers) {
        layer.backgroundColor = inactiveTint.CGColor;
    }
}

- (void)setIndicatorPadding:(CGFloat)indicatorPadding {
    _indicatorPadding = indicatorPadding;
    
    [self layoutInactivePageIndicators:self.inactiveLayers];
    [self layoutActivePageIndicator:self.progress];
    
    [self invalidateIntrinsicContentSize];
}

- (void)setIndicatorRadius:(CGFloat)indicatorRadius {
    _indicatorRadius = indicatorRadius;
    
    [self layoutInactivePageIndicators:self.inactiveLayers];
    [self layoutActivePageIndicator:self.progress];
    
    [self invalidateIntrinsicContentSize];
}

- (CGFloat)indicatorDiameter {
    return self.indicatorRadius * 2;
}

@end
