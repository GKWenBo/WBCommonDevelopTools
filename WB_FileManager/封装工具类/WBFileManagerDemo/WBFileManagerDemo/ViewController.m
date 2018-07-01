//
//  ViewController.m
//  WBFileManagerDemo
//
//  Created by WMB on 2017/9/24.
//  Copyright © 2017年 文波. All rights reserved.
//

#import "ViewController.h"
#import "WBFileManager.h"

@interface ViewController ()

@end

@implementation ViewController


// MARK:Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initializeDataSource];
    [self initializeUserInterface];
}

//MARK:Initialize
- (void)initializeDataSource {
    
}

- (void)initializeUserInterface {
    
    NSArray *array = @[@"1",@"2",@"3"];
    
    [kWBFileManager wb_syncWritePlist:array
                               toFile:@"test"
                        directoryType:WBDirectoryCacheType];
    
    id data = [kWBFileManager wb_syncReadPlistWithFile:@"test"
                                         directoryType:WBDirectoryCacheType];
    
    NSLog(@"%@",data);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK:Request

// MARK:Event Response

// MARK:Public Method

// MARK:Private Method

// MARK:Getter && Setter

@end
