//
//  PushLandscaleViewController.m
//  Demo
//
//  Created by WENBO on 2023/8/27.
//

#import "PushLandscaleViewController.h"

@interface PushLandscaleViewController ()

@end

@implementation PushLandscaleViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self addNotification];
}

// MARK: - 通知

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)screenRotate:(NSNotification*)notification {
    UIDevice* device = notification.object;
    NSLog(@"notification:::%@", @(device.orientation));
    
    if (device.orientation == UIDeviceOrientationPortrait) {
        [self back];
    }
    
    /*
     UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
     UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
     UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
     UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
     */
    
}

- (void)back {
    __weak typeof(self) weakSelf = self;
    [self.navigationController popViewControllerAnimated:YES];
    if (weakSelf.didDismiss) {
        weakSelf.didDismiss();
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self back];
}

// MARK: - 屏幕旋转相关
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}
@end
