//
//  LHManagerViewController.m
//  Demos
//
//  Created by tang on 2018/10/19.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "LHManagerViewController.h"
#import "LunHuiManager.h"

@interface LHManagerViewController ()

@end

@implementation LHManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LHMakeRoleView *roleView = [[LHMakeRoleView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:roleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
