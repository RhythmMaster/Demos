//
//  TZLEmitterViewController.m
//  Demos
//
//  Created by tang on 2018/9/20.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLEmitterViewController.h"

#import "TZLEmitterRainViewController.h"
#import "TZLEmitterSnowViewController.h"
#import "TZLEmitterRedPackageViewController.h"
#import "TZLEmitterColorViewController.h"
#import "TZLEmitterColorViewController.h"

@interface TZLEmitterViewController ()

@end

@implementation TZLEmitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"下雨", @"下雪", @"红包雨", @"多彩泡泡"];
    self.controllerArr = @[[TZLEmitterRainViewController class], [TZLEmitterSnowViewController class],
                           [TZLEmitterRedPackageViewController class], [TZLEmitterColorViewController class]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
