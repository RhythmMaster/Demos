//
//  TZLCoreAnimationHightVC.m
//  Demos
//
//  Created by tang on 2018/12/3.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLCoreAnimationHightVC.h"

#import "TZLCoreAnimationHeightViewController.h"

@interface TZLCoreAnimationHightVC ()

@end

@implementation TZLCoreAnimationHightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"1. contents属性,contentsGravity",
                     @"2. contentsRect",
                     @"3. anchorPoint",
                     @"4. zPosition改变图层顺序",
                     @"5. Hit Testing"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        TZLCoreAnimationHeightViewController *vc = [TZLCoreAnimationHeightViewController new];
        vc.index = indexPath.row;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}



@end
