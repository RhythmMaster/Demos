//
//  TZLMBProgressHUDListVC.m
//  Demos
//
//  Created by tang on 2018/11/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLMBProgressHUDListVC.h"

#import "TZLMBProgressHUDViewController.h"

@implementation TZLMBProgressHUDListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"1. 默认模式,使用系统自带的指示器 ,不能显示进度,只能不停地转呀转 MBProgressHUDModeIndeterminate",
                     @"2. 用饼状图显示进度 MBProgressHUDModeDeterminate",
                     @"3. 进度条 MBProgressHUDModeDeterminateHorizontalBar",
                     @"4. 圆环 MBProgressHUDModeAnnularDeterminate",
                     @"5. 自定义视图 MBProgressHUDModeCustomView",
                     @"6. 只显示文字 MBProgressHUDModeText",
                     @"7. 组合(指示器(customView也是),文本框,详情文本框,背景框4个部分组成)"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        TZLMBProgressHUDViewController *vc = [TZLMBProgressHUDViewController new];
        vc.index = indexPath.row;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
