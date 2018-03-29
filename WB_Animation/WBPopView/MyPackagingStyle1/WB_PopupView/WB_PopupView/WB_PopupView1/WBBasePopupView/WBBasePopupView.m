//
//  WB_BasePopupView.m
//  WB_PopupView1
//
//  Created by WMB on 2017/6/12.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "WBBasePopupView.h"

#define ContentWidth 275.f
#define ContentHeight 200.f

@interface WBBasePopupView ()

@property (nonatomic,strong) UIView * wb_backgroundView;


@end

@implementation WBBasePopupView

#pragma mark -- 初始化
#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configDefautUI];
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configDefautUI];
        [self configUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self configDefautUI];
        [self configUI];
    }
    return self;
}

#pragma mark --------  设置视图  --------
#pragma mark
- (void)configDefautUI {
    _cornerRadius = 6.f;
    _contentSize = CGSizeMake(ContentWidth, ContentHeight);
    
    self.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.wb_backgroundView];
    [self addSubview:self.contentView];
    
}
- (void)configUI {
    //config subviews
    
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
    //[self configUI];
    self.contentView.bounds = CGRectMake(0, 0, _contentSize.width, _contentSize.height);
    self.contentView.center = self.center;
    
}

#pragma mark --------  动画方法  --------
#pragma mark
/**  显示动画  */
- (void)wb_showHUDAnimation {
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    switch (self.animationStyle) {
        case WBShowHUDPositionStyleDefault:
        {
            [UIView animateWithDuration:0.f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.contentView.layer setValue:@(0) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.23f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [self.contentView.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.09f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [self.contentView.layer setValue:@(0.9) forKeyPath:@"transform.scale"];
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.02f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            [self.contentView.layer setValue:@(1) forKeyPath:@"transform.scale"];
                        } completion:^(BOOL finished) {
                        }];
                    }];
                }];
            }];
        }
            break;
        case WBShowHUDPositionStyleTop:
        {
            CGPoint startPoint = CGPointMake(self.center.x, - self.contentView.frame.size.height);
            self.contentView.layer.position = startPoint;
            
            [UIView animateWithDuration:0.8f delay:0.f usingSpringWithDamping:0.5f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseIn animations:^{
               
                self.contentView.layer.position = self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case WBShowHUDPositionStyleLeft:
        {
            CGPoint startPoint = CGPointMake(-_contentSize.width, self.center.y);
            self.contentView.layer.position = startPoint;
            [UIView animateWithDuration:0.8f delay:0.f usingSpringWithDamping:0.5f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                self.contentView.layer.position = self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case WBShowHUDPositionStyleBottom:
        {
            CGPoint startPoint = CGPointMake(self.center.x, self.frame.size.height);
            self.contentView.layer.position = startPoint;
            [UIView animateWithDuration:0.8f delay:0.f usingSpringWithDamping:0.5f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                self.contentView.layer.position = self.center;
                
            } completion:^(BOOL finished) {
                
            }];

        }
            break;
            
        case WBShowHUDPositionStyleRight:
        {
            CGPoint startPoint = CGPointMake(2 * _contentSize.width, self.center.y);
            self.contentView.layer.position = startPoint;
            [UIView animateWithDuration:0.8f delay:0.f usingSpringWithDamping:0.5f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.contentView.layer.position = self.center;
            } completion:^(BOOL finished) {
            }];
        }
            break;
        default:
            break;
    }
}

- (void)wb_hideHUDAnimation {
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.alpha = 0.f;
        self.contentView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -- 绘图
#pragma mark
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark -- Getter and Setter
#pragma mark
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = _cornerRadius;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
- (UIView *)wb_backgroundView {
    if (!_wb_backgroundView) {
        _wb_backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _wb_backgroundView.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.7];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wb_hideHUDAnimation)];
        [_wb_backgroundView addGestureRecognizer:tap];
    }
    return _wb_backgroundView;
}

@end
