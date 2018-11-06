//
//  TZLAddVCMeunViewController.m
//  Demos
//
//  Created by tang on 2018/10/24.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLAddVCMeunViewController.h"
#import "TZLAddVCOneViewController.h"

@interface TZLAddVCMeunViewController ()

@end

@implementation TZLAddVCMeunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.dataArr = @[@"添加控制器", @"带动画的控制器添加"];
    self.controllerArr = @[[TZLAddVCOneViewController class]];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        if (indexPath.row == 1) {
            TZLAddVCOneViewController *VC = [[TZLAddVCOneViewController alloc] init];
            VC.haveAnimate = YES;
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
