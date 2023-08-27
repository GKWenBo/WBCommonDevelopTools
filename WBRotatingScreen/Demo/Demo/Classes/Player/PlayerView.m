//
//  PlayerView.m
//  Demo
//
//  Created by WENBO on 2023/8/27.
//

#import "PlayerView.h"
#import "Masonry.h"

@interface PlayerView ()

@property (nonatomic, strong) UIButton* backButton;

@property (nonatomic, strong) UIButton* fullScreenButton;

@end

@implementation PlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.backgroundColor = [UIColor orangeColor];
    self.tag = 1001;
    
    [self addSubview:self.backButton];
    [self addSubview:self.fullScreenButton];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(44);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@30);
    }];
    
    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@30);
    }];
}

// MARK: - Event Response
- (void)back {
    if (self.backBlock) {
        self.backBlock();
    }
}

- (void)fullScreen {
    if (self.fullscreenBlock) {
        self.fullscreenBlock();
    }
}

// MARK: - getter
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [self buttonWithTitle:@"返回" selName:@"back"];
    }
    
    return _backButton;
}

- (UIButton *)fullScreenButton{
    if (!_fullScreenButton) {
        _fullScreenButton = [self buttonWithTitle:@"全屏" selName:@"fullScreen"];
    }
    
    return _fullScreenButton;
}

- (UIButton*)buttonWithTitle:(NSString *)title selName:(NSString *)selName {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:title forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button addTarget:self action:NSSelectorFromString(selName) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}


@end
