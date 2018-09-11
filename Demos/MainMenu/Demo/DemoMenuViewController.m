//
//  DemoMenuViewController.m
//  Demos
//
//  Created by tang on 2018/9/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "DemoMenuViewController.h"
#import "PullDownHeadViewController.h"
#import "TZLWaterfallViewController.h"

@interface DemoMenuViewController ()

@end

@implementation DemoMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"模仿朋友圈顶部下拉效果", @"瀑布流的简单实现思路"];
    self.controllerArr = @[[PullDownHeadViewController class], [TZLWaterfallViewController class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
