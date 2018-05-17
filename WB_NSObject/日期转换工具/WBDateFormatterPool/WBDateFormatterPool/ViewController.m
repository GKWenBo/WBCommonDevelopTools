//
//  ViewController.m
//  WBDateFormatterPool
//
//  Created by wenbo on 2018/5/16.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "ViewController.h"
#import "WBDateFormatterPool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    WBDateFormatterPool *dateFormatter = [WBDateFormatterPool shareInstance];
    NSString *format = @"yyyy:MM:dd HH:mm:ss";
    NSDateFormatter *myFirstFormatter = [dateFormatter wb_dateFormatterWithFormat:format];
    NSDateFormatter *mySecondFormatter = [dateFormatter wb_dateFormatterWithFormat:format];
    NSLog(@"myFirstFormatter:%@",myFirstFormatter);
    NSLog(@"mySecondFormatter:%@",mySecondFormatter);
    
    [self testCreatForamtterEverryTime];
    [self testCreatForamtterOneTime];
    
}

- (void)testCreatForamtterEverryTime {
    
    NSTimeInterval begin = CACurrentMediaTime();
    NSMutableArray *dateStringArray = [NSMutableArray array];
    
    for (int i = 0; i < 100000; i ++) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.locale = [NSLocale currentLocale];
        [dateStringArray addObject:[dateFormatter stringFromDate:[NSDate date]]];
        
    }
    
    NSTimeInterval end = CACurrentMediaTime();
    
    NSLog(@"testCreatForamtterEverryTime: %lf", end - begin);
}

- (void)testCreatForamtterOneTime {
    
    NSTimeInterval begin = CACurrentMediaTime();
    NSMutableArray *dateStringArray = [NSMutableArray array];
    
    for (int i = 0; i < 100000; i ++) {
        
        NSDateFormatter *dateFormatter = [[WBDateFormatterPool shareInstance] wb_dateFormatterWithFormat:NSDateFormatterLongStyle timeStyle:NSDateFormatterMediumStyle];
        [dateStringArray addObject:[dateFormatter stringFromDate:[NSDate date]]];
        
    }
    
    NSTimeInterval end = CACurrentMediaTime();
    
    NSLog(@"testCreatForamtterOneTime: %lf", end - begin);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
