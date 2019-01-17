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
#import "DrawCardViewController.h"
#import "TZLAddVCMeunViewController.h"
#import "TZLViewLoadingAnimationViewController.h"
#import "TZLDistributionViewController.h"
#import "TZLSystemAlbumViewController.h"
#import "TZLCircleImageViewController.h"
#import "TZLAfterDelayListViewController.h"

#import "TZLUITextFieldViewController.h"
#import "TZLGIFViewController.h"
#import "TZLRuntimeDemoListVC.h"

#import "TZLCoreMotionListVC.h"
#import "TZLGIFPlayerViewController.h"
#import "TZLEmptyTableViewVC.h"
#import "TZLApliyHomeViewController.h"

@interface DemoMenuViewController ()

@end

@implementation DemoMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"模仿朋友圈顶部下拉效果", @"瀑布流的简单实现思路",
                     @"模拟率土之滨抽卡", @"添加子控制器分二步",
                     @"view的网络加载过度动画", @"带三角形的突出view",
                     @"系统相册的调用", @"圆形图片",
                     @"几种延时操作", @"修改UITextField",
                     @"取出gif图的每一帧,再利用UIImageView定时更换image达到播放gif",
                     @"利用runtime做一些事情的demo",
                     @"CoreMotion 利用系统硬件的框架,比如重力弹球",
                     @"GIF的播放方式",
                     @"tableView无数据时候",
                     @"支付宝首页效果"];
    self.controllerArr = @[[PullDownHeadViewController class], [TZLWaterfallViewController class],
                           [DrawCardViewController class], [TZLAddVCMeunViewController class], 
                           [TZLViewLoadingAnimationViewController class], [TZLDistributionViewController class],
                           [TZLSystemAlbumViewController class], [TZLCircleImageViewController class],
                           [TZLAfterDelayListViewController class], [TZLUITextFieldViewController class],
                           [TZLGIFViewController class],
                           [TZLRuntimeDemoListVC class],
                           [TZLCoreMotionListVC class],
                           [TZLGIFPlayerViewController class],
                           [TZLEmptyTableViewVC class],
                           [TZLApliyHomeViewController class]];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
