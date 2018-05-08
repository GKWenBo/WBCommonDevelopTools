//
//  ViewController.m
//  WBCustomSearchBar
//
//  Created by wenbo on 2018/4/25.
//  Copyright © 2018年 wenbo. All rights reserved.
//

#import "ViewController.h"
#import "WBCustomSearchBar.h"

@interface ViewController ()
{
    WBCustomSearchBar *_searchBar;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _searchBar = [[WBCustomSearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
//    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    UITextField *textField = [_searchBar valueForKey:@"searchField"];
    if (textField) {
        textField.layer.cornerRadius = 16;
        textField.layer.masksToBounds = YES;

    }
    [self.view addSubview:_searchBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
