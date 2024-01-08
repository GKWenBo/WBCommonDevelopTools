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
}

- (void)loggerTest {
    [WBLogger error:@"error log"];
    [WBLogger warning:@"warning log"];
    [WBLogger debug:@"debug log"];
    [WBLogger info:@"info log"];
    [WBLogger fault:@"fault log"];
    [WBLogger notice:@"notice log"];
    [WBLogger trice:@"trice log"];
    [WBLogger critical:@"critical log"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self loggerTest];
}

@end
