//
//  WBDecorationView.m
//  WBCollectionViewDrag
//
//  Created by wenbo on 2022/2/28.
//

#import "WBDecorationView.h"

@implementation WBDecorationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:242/255.0 green:243/255.0 blue:246/255.0 alpha:1/1.0];
        self.backgroundColor = UIColor.redColor;
        self.layer.cornerRadius = 4.f;
    }
    return self;
}


@end
