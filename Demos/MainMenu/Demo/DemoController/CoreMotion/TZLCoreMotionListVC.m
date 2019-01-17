//
//  TZLCoreMotionListVC.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLCoreMotionListVC.h"

#import "TZLMobaiViewController.h"

@implementation TZLCoreMotionListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"仿摩拜贴纸小球碰撞动画"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        TZLMobaiViewController *vc = [TZLMobaiViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
@end
