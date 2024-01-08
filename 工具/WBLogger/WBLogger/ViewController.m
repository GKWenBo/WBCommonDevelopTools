//
//  ViewController.m
//  WBLogger
//
//  Created by wenbo22 on 2024/1/8.
//

#import "ViewController.h"
#import "WBLogger-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [WBLogger warning:@"test print log"];
}


@end
