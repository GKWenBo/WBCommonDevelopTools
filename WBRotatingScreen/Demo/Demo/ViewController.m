//
//  ViewController.m
//  Demo
//
//  Created by WENBO on 2023/8/27.
//

#import "ViewController.h"
#import "PortraitViewController.h"
#import "PushPortraitViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"屏幕旋转Demo";
}


// MARK: - Action
- (IBAction)presentAction:(id)sender {
    PortraitViewController *vc = [[PortraitViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)pushAction:(id)sender {
    PushPortraitViewController *vc = [[PushPortraitViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
