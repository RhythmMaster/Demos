//
//  TZLStudyViewController.m
//  Demos
//
//  Created by tang on 2018/9/20.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLStudyViewController.h"
#import "TZLEmitterViewController.h"

@interface TZLStudyViewController ()

@end

@implementation TZLStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"粒子发射"];
    self.controllerArr = @[[TZLEmitterViewController class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
