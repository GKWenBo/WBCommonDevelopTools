//
//  PlayerView.h
//  Demo
//
//  Created by WENBO on 2023/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerView : UIView

@property (nonatomic, strong, readonly) UIButton* backButton;

@property (nonatomic, strong, readonly) UIButton* fullScreenButton;

@property (nonatomic, copy) void (^backBlock)(void);
@property (nonatomic, copy) void (^fullscreenBlock)(void);

@end

NS_ASSUME_NONNULL_END
