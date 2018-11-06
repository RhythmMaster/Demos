//
//  TZLGamesMenuViewController.m
//  Demos
//
//  Created by tang on 2018/10/19.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLGamesMenuViewController.h"

#import "LHManagerViewController.h"

@interface TZLGamesMenuViewController ()

@end

@implementation TZLGamesMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜单列表";
    self.dataArr = @[@"轮回"];
    self.controllerArr = @[[LHManagerViewController class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
