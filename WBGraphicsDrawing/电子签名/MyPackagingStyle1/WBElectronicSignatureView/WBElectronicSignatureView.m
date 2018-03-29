//
//  ElectronicSignatureView.m
//  ElectronicSignatureDemo
//
//  Created by Admin on 2017/8/7.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBElectronicSignatureView.h"

@interface WBElectronicSignatureView ()
{
    CGFloat lineWidth;/**  默认3  */
    UIColor * lineColor;/**  默认黑色  */
}
@end

@implementation WBElectronicSignatureView

- (instancetype)init
{
    self = [super init];
    if (self) {
        lineWidth = 3.f;
        lineColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        lineWidth = 3.f;
        lineColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        lineWidth = 3.f;
        lineColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark -- Method
#pragma mark
- (void)clear {
    [self.points removeAllObjects];
    [self setNeedsDisplay];
}
- (void)back {
    [self.points removeAllObjects];
    [self setNeedsDisplay];
}

/**  起点  */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:touch.view];
    /**  添加路径  */
    UIBezierPath * path = [UIBezierPath bezierPath];
    /**  设置路径起始点为圆点  */
    path.lineCapStyle = kCGLineCapRound;
    /**  设置路径结束点为原点  */
    path.lineJoinStyle = kCGLineCapRound;
    /**  路径的起始点用 moveToPoint  */
    [path moveToPoint:startPoint];
    [self.points addObject:path];
    [self setNeedsDisplay];
}

/**  连线  */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint currentPoints = [touch locationInView:touch.view];
    UIBezierPath * currentPath = [self.points lastObject];
    [currentPath addLineToPoint:currentPoints];
    /**  刷新帧  */
    [self setNeedsDisplay];
}

/**  触摸结束  */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    /**  设置线条颜色  */
    [lineColor set];
    for (UIBezierPath * path in self.points) {
        path.lineWidth = lineWidth;
        [path stroke];/**  闭合  */
    }
}

#pragma mark -- getter and setter
#pragma mark
- (void)setSignLineColor:(UIColor *)signLineColor {
    _signLineColor = signLineColor;
    lineColor = signLineColor;
}

- (void)setSignLineWidth:(CGFloat)signLineWidth {
    _signLineWidth = signLineWidth;
    lineWidth = signLineWidth;
}

- (NSMutableArray *)points {
    if (!_points) {
        _points = [[NSMutableArray alloc]init];
    }
    return _points;
}

@end

@implementation UIImage (WB_Capture)
+ (instancetype)captureWithView:(UIView *)view
{
    /**
     *  开启上下文
     */
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    /**
     *  将控制器的view的layer渲染到上下文
     */
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    /**
     *  取出图片
     */
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    /**
     *  结束上下文
     */
    UIGraphicsEndImageContext();
    return newImage;
    
}
@end
