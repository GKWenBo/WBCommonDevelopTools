//
//  LandscaleViewController.m
//  Demo
//
//  Created by WENBO on 2023/8/27.
//

#import "LandscaleViewController.h"

@interface LandscaleViewController ()

@end

@implementation LandscaleViewController


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
        
        __weak typeof(self) weakSelf = self;
        [self dismissViewControllerAnimated:YES completion:^{
            if (weakSelf.didDismiss) {
                weakSelf.didDismiss();
            }
        }];
    }
    
    /*
     UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
     UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
     UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
     UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
     */
    
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
