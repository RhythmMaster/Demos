//
//  TZLCustomScrollViewController.m
//  Demos
//
//  Created by tang on 2018/12/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLCustomScrollViewController.h"

#import "TZLCustomScrollerView.h"

@interface TZLCustomScrollViewController ()

@end

@implementation TZLCustomScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    TZLCustomScrollerView *scrollView = [TZLCustomScrollerView new];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = CGRectMake(0, 0, 300, 300);
    scrollView.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.5);
    
    [self.view addSubview:scrollView];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    redView.center = CGPointMake(scrollView.width * 0.5, scrollView.height * 0.5);
    redView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:redView];
}


@end
