//
//  WB_BadgeView.m
//  WB_BadgeViewDemo
//
//  Created by Admin on 2017/7/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBBadgeView.h"
#import <QuartzCore/QuartzCore.h>
#include <mach-o/dyld.h>

#if !__has_feature(objc_arc)
#error WB_BadgeView must be compiled with ARC.
#endif

// Silencing some deprecation warnings if your deployment target is iOS7 that can only be fixed by using methods that
// Are only available on iOS7.
// Soon DWQBadgeView will require iOS 7 and we'll be able to use the new methods.
#if  __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
#define WB_BadgeViewSilenceDeprecatedMethodStart()   _Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
#define WB_BadgeViewSilenceDeprecatedMethodEnd()     _Pragma("clang diagnostic pop")
#else
#define WB_BadgeViewSilenceDeprecatedMethodStart()
#define WB_BadgeViewSilenceDeprecatedMethodEnd()
#endif

static const CGFloat WB_BadgeViewShadowRadius = 1.0f;
static const CGFloat WB_BadgeViewHeight = 16.0f;
static const CGFloat WB_BadgeViewTextSideMargin = 8.0f;
static const CGFloat WB_BadgeViewCornerRadius = 10.0f;

static BOOL WB_BadgeViewIsUIKitFlatMode(void)
{
    static BOOL isUIKitFlatMode = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifndef kCFCoreFoundationVersionNumber_iOS_7_0
#define kCFCoreFoundationVersionNumber_iOS_7_0 847.2
#endif
#ifndef UIKitVersionNumber_iOS_7_0
#define UIKitVersionNumber_iOS_7_0 0xB57
#endif
        // We get the modern UIKit if system is running >= iOS 7 and we were linked with >= SDK 7.
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0) {
            isUIKitFlatMode = (NSVersionOfLinkTimeLibrary("UIKit") >> 16) >= UIKitVersionNumber_iOS_7_0;
        }
    });
    
    return isUIKitFlatMode;
}
@implementation WBBadgeView

+ (void)applyCommonStyle
{
    WBBadgeView *badgeViewAppearanceProxy = WBBadgeView.appearance;
    
    badgeViewAppearanceProxy.backgroundColor = UIColor.clearColor;
    badgeViewAppearanceProxy.badgeAlignment = WBBadgeViewAlignmentTopRight;
    badgeViewAppearanceProxy.badgeBackgroundColor = UIColor.redColor;
    badgeViewAppearanceProxy.badgeTextFont = [UIFont boldSystemFontOfSize:UIFont.systemFontSize];
    badgeViewAppearanceProxy.badgeTextColor = UIColor.whiteColor;
}

+ (void)applyLegacyStyle
{
    WBBadgeView *badgeViewAppearanceProxy = WBBadgeView.appearance;
    
    badgeViewAppearanceProxy.badgeOverlayColor = [UIColor colorWithWhite:1.0f alpha:0.3];
    badgeViewAppearanceProxy.badgeTextShadowColor = UIColor.clearColor;
    badgeViewAppearanceProxy.badgeShadowColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    badgeViewAppearanceProxy.badgeShadowSize = CGSizeMake(0.0f, 3.0f);
    badgeViewAppearanceProxy.badgeStrokeWidth = 2.0f;
    badgeViewAppearanceProxy.badgeStrokeColor = UIColor.whiteColor;
}

+ (void)applyIOS7Style
{
    WBBadgeView *badgeViewAppearanceProxy = WBBadgeView.appearance;
    
    badgeViewAppearanceProxy.badgeOverlayColor = UIColor.clearColor;
    badgeViewAppearanceProxy.badgeTextShadowColor = UIColor.clearColor;
    badgeViewAppearanceProxy.badgeShadowColor = UIColor.clearColor;
    badgeViewAppearanceProxy.badgeStrokeWidth = 0.0f;
    badgeViewAppearanceProxy.badgeStrokeColor = badgeViewAppearanceProxy.badgeBackgroundColor;
}

+ (void)initialize {
    if (self == [WBBadgeView class]) {
        [self applyCommonStyle];
        if (WB_BadgeViewIsUIKitFlatMode()) {
            [self applyIOS7Style];
        } else {
            [self applyLegacyStyle];
        }
    }
}

- (id)initWithParentView:(UIView *)parentView alignment:(WBBadgeViewAlighnment)alignment {
    if (self == [self initWithFrame:CGRectZero]) {
        self.badgeAlignment = WBBadgeViewAlignmentTopRight;
        [parentView addSubview:self];
    }
    return self;
}

#pragma mark -- Layout
#pragma mark
- (CGFloat)marginToDrawInside {
    return self.badgeStrokeWidth * 2.f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect newFrame = self.frame;
    const CGRect superviewBounds = CGRectIsEmpty(_frameToPositionInRelationWith) ? self.superview.bounds : _frameToPositionInRelationWith;
    const CGFloat textWidth = [self sizeOfTextForCurrentSettings].width;
    const CGFloat marginToDrawInside = [self marginToDrawInside];
    const CGFloat viewWidth = MAX(_badgeMinWidth, textWidth + WB_BadgeViewTextSideMargin + (marginToDrawInside * 2));
    const CGFloat viewHeight = WB_BadgeViewHeight + (marginToDrawInside * 2);
    const CGFloat superviewWidth = superviewBounds.size.width;
    const CGFloat superviewHeight = superviewBounds.size.height;
    newFrame.size.width = MAX(viewWidth, viewHeight);
    newFrame.size.height = viewHeight;
    switch (self.badgeAlignment) {
        case WBBadgeViewAlignmentTopLeft:
            newFrame.origin.x = -viewWidth / 2.0f;
            newFrame.origin.y = -viewHeight / 2.0f;
            break;
        case WBBadgeViewAlignmentTopRight:
            newFrame.origin.x = superviewWidth - (viewWidth / 2.0f);
            newFrame.origin.y = -viewHeight / 2.0f;
            break;
        case WBBadgeViewAlignmentTopCenter:
            newFrame.origin.x = (superviewWidth - viewWidth) / 2.0f;
            newFrame.origin.y = -viewHeight / 2.0f;
            break;
        case WBBadgeViewAlignmentCenterLeft:
            newFrame.origin.x = -viewWidth / 2.0f;
            newFrame.origin.y = (superviewHeight - viewHeight) / 2.0f;
            break;
        case WBBadgeViewAlignmentCenterRight:
            newFrame.origin.x = superviewWidth - (viewWidth / 2.0f);
            newFrame.origin.y = (superviewHeight - viewHeight) / 2.0f;
            break;
        case WBBadgeViewAlignmentBottomLeft:
            newFrame.origin.x = -viewWidth / 2.0f;
            newFrame.origin.y = superviewHeight - (viewHeight / 2.0f);
            break;
        case WBBadgeViewAlignmentBottomRight:
            newFrame.origin.x = superviewWidth - (viewWidth / 2.0f);
            newFrame.origin.y = superviewHeight - (viewHeight / 2.0f);
            break;
        case WBBadgeViewAlignmentBottomCenter:
            newFrame.origin.x = (superviewWidth - viewWidth) / 2.0f;
            newFrame.origin.y = superviewHeight - (viewHeight / 2.0f);
            break;
        case WBBadgeViewAlignmentCenter:
            newFrame.origin.x = (superviewWidth - viewWidth) / 2.0f;
            newFrame.origin.y = (superviewHeight - viewHeight) / 2.0f;
            break;
        default:
            NSAssert(NO, @"Unimplemented DWQBadgeAligment type %lul", (unsigned long)self.badgeAlignment);
    }
    
    newFrame.origin.x += _badgePositionAdjustment.x;
    newFrame.origin.y += _badgePositionAdjustment.y;
    
    // Do not set frame directly so we do not interfere with any potential transform set on the view.
    self.bounds = CGRectIntegral(CGRectMake(0, 0, CGRectGetWidth(newFrame), CGRectGetHeight(newFrame)));
    self.center = CGPointMake(ceilf(CGRectGetMidX(newFrame)), ceilf(CGRectGetMidY(newFrame)));
    
    [self setNeedsDisplay];
}

#pragma mark - Private

- (CGSize)sizeOfTextForCurrentSettings
{
    WB_BadgeViewSilenceDeprecatedMethodStart();
    return [self.badgeText sizeWithFont:self.badgeTextFont];
    WB_BadgeViewSilenceDeprecatedMethodEnd();
}

#pragma mark -- getter and setter
#pragma mark
- (void)setBadgeAlignment:(WBBadgeViewAlighnment)badgeAlignment {
    if (badgeAlignment != _badgeAlignment) {
        _badgeAlignment = badgeAlignment;
        [self setNeedsDisplay];
    }
}

- (void)setBadgePositionAdjustment:(CGPoint)badgePositionAdjustment {
    _badgePositionAdjustment = badgePositionAdjustment;
    [self setNeedsDisplay];
}

- (void)setBadgeText:(NSString *)badgeText {
    if (badgeText != _badgeText) {
        _badgeText = [badgeText copy];
        [self setNeedsDisplay];
    }
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    if (badgeTextColor != _badgeTextColor) {
        _badgeTextColor = badgeTextColor;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeTextShadowColor:(UIColor *)badgeTextShadowColor {
    if (badgeTextShadowColor != _badgeTextShadowColor) {
        _badgeTextShadowColor = badgeTextShadowColor;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeTextShadowOffset:(CGSize)badgeTextShadowOffset {
    _badgeTextShadowOffset = badgeTextShadowOffset;
    [self setNeedsDisplay];
}

- (void)setBadgeTextFont:(UIFont *)badgeTextFont {
    if (badgeTextFont != _badgeTextFont) {
        _badgeTextFont = badgeTextFont;
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor {
    if (badgeBackgroundColor != _badgeBackgroundColor) {
        _badgeBackgroundColor = badgeBackgroundColor;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeStrokeWidth:(CGFloat)badgeStrokeWidth
{
    if (badgeStrokeWidth != _badgeStrokeWidth)
    {
        _badgeStrokeWidth = badgeStrokeWidth;
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
}

- (void)setBadgeStrokeColor:(UIColor *)badgeStrokeColor
{
    if (badgeStrokeColor != _badgeStrokeColor)
    {
        _badgeStrokeColor = badgeStrokeColor;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeShadowColor:(UIColor *)badgeShadowColor
{
    if (badgeShadowColor != _badgeShadowColor)
    {
        _badgeShadowColor = badgeShadowColor;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeShadowSize:(CGSize)badgeShadowSize
{
    if (!CGSizeEqualToSize(badgeShadowSize, _badgeShadowSize))
    {
        _badgeShadowSize = badgeShadowSize;
        [self setNeedsDisplay];
    }
}

#pragma mark -- Drawing
#pragma mark
- (void)drawRect:(CGRect)rect {
    const BOOL anyTextToDraw = (self.badgeText.length > 0);
    if (anyTextToDraw) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        const CGFloat marginToDrawInside = [self marginToDrawInside];
        const CGRect rectToDraw = CGRectInset(rect, marginToDrawInside, marginToDrawInside);
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:rectToDraw byRoundingCorners:(UIRectCorner)UIRectCornerAllCorners cornerRadii:CGSizeMake(WB_BadgeViewCornerRadius, WB_BadgeViewCornerRadius)];
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, borderPath.CGPath);
            CGContextSetFillColorWithColor(ctx, self.badgeBackgroundColor.CGColor);
            CGContextSetShadowWithColor(ctx, self.badgeShadowSize, WB_BadgeViewShadowRadius, self.badgeShadowColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        const BOOL colorForOverlayPresent = self.badgeOverlayColor && ![self.badgeOverlayColor isEqual:[UIColor clearColor]];
        
        if (colorForOverlayPresent)
        {
            /* Gradient overlay */
            CGContextSaveGState(ctx);
            {
                CGContextAddPath(ctx, borderPath.CGPath);
                CGContextClip(ctx);
                const CGFloat height = rectToDraw.size.height;
                const CGFloat width = rectToDraw.size.width;
                const CGRect rectForOverlayCircle = CGRectMake(rectToDraw.origin.x,
                                                               rectToDraw.origin.y - ceilf(height * 0.5),
                                                               width,
                                                               height);
                
                CGContextAddEllipseInRect(ctx, rectForOverlayCircle);
                CGContextSetFillColorWithColor(ctx, self.badgeOverlayColor.CGColor);
                
                CGContextDrawPath(ctx, kCGPathFill);
            }
            CGContextRestoreGState(ctx);
        }
        /* Stroke */
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, borderPath.CGPath);
            
            CGContextSetLineWidth(ctx, self.badgeStrokeWidth);
            CGContextSetStrokeColorWithColor(ctx, self.badgeStrokeColor.CGColor);
            CGContextDrawPath(ctx, kCGPathStroke);
        }
        CGContextRestoreGState(ctx);
        /* Text */
        CGContextSaveGState(ctx);
        {
            CGContextSetFillColorWithColor(ctx, self.badgeTextColor.CGColor);
            CGContextSetShadowWithColor(ctx, self.badgeTextShadowOffset, 1.0, self.badgeTextShadowColor.CGColor);
            CGRect textFrame = rectToDraw;
            const CGSize textSize = [self sizeOfTextForCurrentSettings];
            textFrame.size.height = textSize.height;
            textFrame.origin.y = rectToDraw.origin.y + floorf((rectToDraw.size.height - textFrame.size.height) / 2.0f);
            WB_BadgeViewSilenceDeprecatedMethodStart();
            [self.badgeText drawInRect:textFrame
                              withFont:self.badgeTextFont
                         lineBreakMode:NSLineBreakByClipping
                             alignment:NSTextAlignmentCenter];
            WB_BadgeViewSilenceDeprecatedMethodEnd();
        }
        CGContextRestoreGState(ctx);
    }
}
@end
