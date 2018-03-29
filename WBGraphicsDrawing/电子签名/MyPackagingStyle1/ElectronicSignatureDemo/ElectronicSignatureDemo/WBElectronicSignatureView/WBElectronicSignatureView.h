//
//  ElectronicSignatureView.h
//  ElectronicSignatureDemo
//
//  Created by Admin on 2017/8/7.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBElectronicSignatureView : UIView
@property (nonatomic,assign) CGFloat signLineWidth;/**  默认3  */
@property (nonatomic,strong) UIColor * signLineColor;/**  默认黑色  */
@property (nonatomic,strong) NSMutableArray * points;/**  保存touches点  */

- (void)clear;/**  清空  */
- (void)back;/**  返回  */

@end

@interface UIImage (WB_Capture)

+ (instancetype)captureWithView:(UIView *)view;

@end
