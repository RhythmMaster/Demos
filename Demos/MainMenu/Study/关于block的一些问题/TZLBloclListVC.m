//
//  TZLBloclListVC.m
//  Demos
//
//  Created by tang on 2019/1/11.
//  Copyright © 2019年 TZL. All rights reserved.
//

#import "TZLBloclListVC.h"
#import "TZLBlockViewController.h"
#import "TZLBlock1ViewController.h"

@implementation TZLBloclListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"初次探索,循环引用 引用计数的问题,本身作用于的问题,为什么copy修饰的问题",
                     @"为什么__block修饰外部变量才能用"];
    
    self.controllerArr = @[[TZLBlockViewController class],
                           [TZLBlock1ViewController class]];
}

@end
