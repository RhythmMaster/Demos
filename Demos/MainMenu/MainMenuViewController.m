//
//  MainMenuViewController.m
//  Demos
//
//  Created by tang on 2018/9/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "MainMenuViewController.h"

#import "DemoMenuViewController.h"
#import "TZLStudyViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主菜单";
    self.dataArr = @[@"功能性demo", @"知识点学习"];
    self.controllerArr = @[[DemoMenuViewController class], [TZLStudyViewController class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
