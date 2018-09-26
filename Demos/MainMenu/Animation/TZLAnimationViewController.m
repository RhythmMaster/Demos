//
//  TZLAnimationViewController.m
//  Demos
//
//  Created by tang on 2018/9/26.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLAnimationViewController.h"

#import "TZLTransformAnimationViewController.h"

@interface TZLAnimationViewController ()

@end

@implementation TZLAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"转场动画"];
    self.controllerArr = @[[TZLTransformAnimationViewController class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
