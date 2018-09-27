//
//  TZLSubTransformViewController.m
//  Demos
//
//  Created by tang on 2018/9/26.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLSubTransformViewController.h"
#import "TZLCustomTransformAnimation.h"
#import "UIBarButtonItem+HZBarButtonItem.h"
@interface TZLSubTransformViewController ()
/**  */
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDriven;
@end

@implementation TZLSubTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self imageView];
    if (!self.noEx) {
        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] createBarItemWithImageName:@"1" name:@"模态转场" target:self action:@selector(rightAction:)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
    } else {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor blueColor];
        btn.frame = CGRectMake(20, 30, 80, 30);
        [btn setTitle:@"模态返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    TZLNavigationController *naviVC = (TZLNavigationController *)self.navigationController;
    self.navigationController.endTransformAnimation = NO;
    [naviVC validatePanGestureRecognizerWithAnimation:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.endTransformAnimation = YES;
}

- (void)rightAction:(UIButton *)sender {
    TZLSubTransformViewController *subVC = [TZLSubTransformViewController new];
    subVC.noEx = YES;
    [self presentViewController:subVC animated:YES animationView:self.imageView fromFrame:CGRectMake(100, 100, 250, 500) toFrame:CGRectMake(160, 160, 120, 250) completion:nil];
}
- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark lazy
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self.view addSubview:_imageView];
        UIImage *image = [UIImage imageNamed:@"direction"];
        _imageView.frame = CGRectMake(100, 100, 250, 500);
        if (self.noEx) {
            _imageView.frame = CGRectMake(160, 160, 120, 250);
        }
        _imageView.image = image;
        _imageView.tag = 1111;
    }
    return _imageView;
}

@end
