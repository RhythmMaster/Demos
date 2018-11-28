//
//  TZLLockListViewController.m
//  Demos
//
//  Created by tang on 2018/11/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLLockListViewController.h"

#import "TZLLockViewController.h"

@interface TZLLockListViewController ()

@end

@implementation TZLLockListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"一、OSSpinLock自旋锁", @"二、dispatch_semaphore 信号量",
                     @"三、pthread_mutex 互斥锁", @"四、pthread_mutex(recursive) 递归锁,不会让线程锁死的情况出现",
                     @"五、NSLock普通锁", @"六、NSCondition",
                     @"NSLock在递归锁中的错误演示",
                     @"七、synchronized 同步锁", @"八、NSConditionLock 条件锁"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        TZLLockViewController *lockVC = [TZLLockViewController new];
        lockVC.index = indexPath.row;
        [weakSelf.navigationController pushViewController:lockVC animated:YES];
    };
}



@end
