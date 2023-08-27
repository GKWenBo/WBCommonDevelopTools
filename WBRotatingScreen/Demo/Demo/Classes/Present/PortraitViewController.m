//
//  PortraitViewController.m
//  Demo
//
//  Created by WENBO on 2023/8/27.
//

#import "PortraitViewController.h"
#import "LandscaleViewController.h"
#import "PlayerView.h"
#import "Masonry.h"
#import "PresentRotateAnimator.h"
#import "NavigationController.h"

@interface PortraitViewController ()

@property (strong, nonatomic) PlayerView *playView;
@property (nonatomic, strong) PresentRotateAnimator *customAnimator;

@end

@implementation PortraitViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.playView];
    
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(self.playView.mas_width).multipliedBy(9 / 16.0f);
    }];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 150, 200, 100)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSLog(@"view bounds = %@", NSStringFromCGRect(self.view.bounds));
}

// MARK: - 通知
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)screenRotate:(NSNotification*)notification {
    UIDevice* device = notification.object;
    NSLog(@"notification:::%@", @(device.orientation));
    
    if (device.orientation == UIDeviceOrientationLandscapeLeft) {
        [self jumpToHVideo];
    }
    
    /*
     UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
     UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
     UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
     UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
     */
    
}

// MARK: - Private Method
- (void)jumpToHVideo {
    LandscaleViewController *horizontallyVideoVC = [[LandscaleViewController alloc] init];
    
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:horizontallyVideoVC];
    nav.transitioningDelegate = self.customAnimator;
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:^{
        NSLog(@"presentViewController执行完毕，有的时候控制器切换如果有视频在播放可能会有顿，可在执行前和完成之后做一些暂停开始的处理");
    }];
        
    __weak typeof(self) weakSelf = self;
    horizontallyVideoVC.didDismiss = ^(){
        [weakSelf.playView.fullScreenButton setTitle:@"全屏" forState:(UIControlStateNormal)];
    };
    
    [weakSelf.playView.fullScreenButton setTitle:@"小屏" forState:(UIControlStateNormal)];
}

// MARK: - 屏幕旋转相关
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    NSLog(@"'size = %@", NSStringFromCGSize(size));
}

// MARK: - getter
- (PlayerView *)playView {
    if (!_playView) {
        _playView = [[PlayerView alloc] init];
        __weak typeof(self) weakSelf = self;
        _playView.backBlock = ^{
            if ([[weakSelf.playView.fullScreenButton titleForState:(UIControlStateNormal)] isEqualToString:@"小屏"]) {
                
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"dismissViewController执行完毕，有的时候控制器切换如果有视频在播放可能会有顿，可在执行前和完成之后做一些暂停开始的处理");
                }];
                [weakSelf.playView.fullScreenButton setTitle:@"全屏" forState:(UIControlStateNormal)];
            } else {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        };
        
        _playView.fullscreenBlock = ^{
            if ([[weakSelf.playView.fullScreenButton titleForState:(UIControlStateNormal)] isEqualToString:@"小屏"]) {

                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    
                }];
                [weakSelf.playView.fullScreenButton setTitle:@"全屏" forState:(UIControlStateNormal)];
            } else {
                [weakSelf jumpToHVideo];
            }
        };
    }
    return _playView;
}

- (PresentRotateAnimator *)customAnimator
{
    if (!_customAnimator) {
        _customAnimator = [[PresentRotateAnimator alloc] init];
    }
    return _customAnimator;
}

@end
