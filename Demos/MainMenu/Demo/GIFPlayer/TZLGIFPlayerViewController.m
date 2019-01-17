//
//  TZLGIFPlayerViewController.m
//  Demos
//
//  Created by tang on 2018/11/30.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLGIFPlayerViewController.h"
#import "TZLGIFPlayViewController.h"

@interface TZLGIFPlayerViewController ()

@end

@implementation TZLGIFPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"1. 利用WebView播放GIF动画",
                     @"2. 利用UIImageView和ImageIO框架播放"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        TZLGIFPlayViewController *vc = [TZLGIFPlayViewController new];
        vc.index= indexPath.row;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}



@end
