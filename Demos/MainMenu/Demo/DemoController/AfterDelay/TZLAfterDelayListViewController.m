//
//  TZLAfterDelayListViewController.m
//  Demos
//
//  Created by tang on 2018/11/27.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLAfterDelayListViewController.h"
#import "TZLAfterDelayViewController.h"


@interface TZLAfterDelayListViewController ()

@end

@implementation TZLAfterDelayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"一、perform selector方法", @"二、GCD dispatch_after方法",
                     @"三、UIView动画实现延时", @"四、NSThread sleep方法",
                     @"五、NSTime 定时器方法"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        TZLAfterDelayViewController *delayVC = [TZLAfterDelayViewController new];
        delayVC.index = indexPath.row;
        [weakSelf.navigationController pushViewController:delayVC animated:YES];
    };
}



@end
