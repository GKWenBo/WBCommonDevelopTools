//
//  WBCustomPresentViewController.m
//  WBTransitionAnimationDemo
//
//  Created by wenbo on 2022/3/11.
//

#import "WBCustomPresentViewController.h"
#import "WBTransitionAnimation.h"

@interface WBCustomPresentViewController ()

@property (nonatomic, strong) WBTransitionAnimation *animation;

@end

@implementation WBCustomPresentViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        WBTransitionAnimation *animator = [[WBTransitionAnimation alloc] initWithTransitionStyle:WBTransitionAnimationStyleFromTop];
        self.transitioningDelegate = animator;
        _animation = animator;
        
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.orangeColor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
