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
#import "TZLRequestWMViewController.h"
#import "TZLStudyNaviViewController.h"
#import "TZLFrameAndBoundsViewController.h"

#import "TZLLockListViewController.h"
#import "TZLMBProgressHUDListVC.h"
#import "TZLRuntimeListViewController.h"
#import "TZLKVCListViewController.h"
#import "TZLMWPhotoBrowserViewController.h"
#import "TZLCustomScrollViewController.h"
#import "TZLBloclListVC.h"
@interface TZLStudyViewController ()

@end

@implementation TZLStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"粒子发射", @"UIBezierPath和drawRect:(CGRect)rect",
                     @"原生网络请求", @"好好学习下导航栏", @"frame和bounds",
                     @"iOS中的8种锁", @"MBProgressHUD",
                     @"runtime", @"KVC",
                     @"MWPhotoBrowser", @"自定义滚动视图",
                     @"关于block的解惑"];
    self.controllerArr = @[[TZLEmitterViewController class], [TZLUIBezierPathTableViewController class],
                           [TZLRequestWMViewController class], [TZLStudyNaviViewController class],
                           [TZLFrameAndBoundsViewController class], [TZLLockListViewController class],
                           [TZLMBProgressHUDListVC class], [TZLRuntimeListViewController class],
                           [TZLKVCListViewController class],
                           [TZLMWPhotoBrowserViewController class],
                           [TZLCustomScrollViewController class],
                           [TZLBloclListVC class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
