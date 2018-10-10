//
//  TZLStudyViewController.m
//  Demos
//
//  Created by tang on 2018/9/20.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLStudyViewController.h"
#import "TZLEmitterViewController.h"
#import "TZLUIBezierPathTableViewController.h"
#import "TZLNetRequestViewController.h"

@interface TZLStudyViewController ()

@end

@implementation TZLStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"粒子发射", @"UIBezierPath和drawRect:(CGRect)rect",
                     @"原生网络请求"];
    self.controllerArr = @[[TZLEmitterViewController class], [TZLUIBezierPathTableViewController class],
                           [TZLNetRequestViewController class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
