//
//  TZLRuntimeDemoListVC.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLRuntimeDemoListVC.h"
#import "TZLStatisticsViewController.h"

@implementation TZLRuntimeDemoListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"1.统计页面打开次数",
                     @"2.数组越界"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        TZLStatisticsViewController *vc = [TZLStatisticsViewController new];
        vc.index = indexPath.row;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
@end
