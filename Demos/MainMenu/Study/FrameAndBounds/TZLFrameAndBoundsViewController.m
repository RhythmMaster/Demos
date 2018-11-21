//
//  TZLFrameAndBoundsViewController.m
//  Demos
//
//  Created by tang on 2018/11/19.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLFrameAndBoundsViewController.h"

@interface TZLFrameAndBoundsViewController ()
/**  */
@property(nonatomic, strong) UIView *orangeView;
/**  */
@property(nonatomic, strong) UIView *blueView;
@end

@implementation TZLFrameAndBoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *orange = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    [self.view addSubview:orange];
    orange.backgroundColor = [UIColor redColor];
    NSLog(@"orange:%@---%@---%@----%@", NSStringFromCGRect(orange.frame), NSStringFromCGRect(orange.bounds), NSStringFromCGPoint(orange.center), NSStringFromCGPoint(orange.layer.position));
    self.orangeView = orange;
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [orange addSubview:blueView];
    blueView.backgroundColor = [UIColor blueColor];
    NSLog(@"blueView:%@---%@---%@----%@", NSStringFromCGRect(blueView.frame), NSStringFromCGRect(blueView.bounds), NSStringFromCGPoint(blueView.center), NSStringFromCGPoint(blueView.layer.position));
    self.blueView = blueView;
    
    
    UIButton *changeBoundsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:changeBoundsBtn];
    [changeBoundsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(orange.mas_bottom).equalTo(20);
    }];
    [changeBoundsBtn setTitle:@"改变orangeView的bounds" forState:UIControlStateNormal];
    [changeBoundsBtn addTarget:self action:@selector(changeBoundsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *changeAnchorPointBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:changeAnchorPointBtn];
    [changeAnchorPointBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
    [changeAnchorPointBtn setTitle:@"改变orangeView的bounds" forState:UIControlStateNormal];
    [changeAnchorPointBtn addTarget:self action:@selector(changeAnchorPointAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeBoundsAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.orangeView.bounds = CGRectMake(self.orangeView.bounds.origin.x + (sender.selected ? -1: 1) * 20, self.orangeView.bounds.origin.y + (sender.selected ? -1: 1) * 20, self.orangeView.bounds.size.width, self.orangeView.bounds.size.height);
    NSLog(@"orange:%@---%@", NSStringFromCGRect(self.orangeView.frame), NSStringFromCGRect(self.orangeView.bounds));
    NSLog(@"blueView:%@---%@", NSStringFromCGRect(self.blueView.frame), NSStringFromCGRect(self.blueView.bounds));
}
- (void)changeAnchorPointAction:(UIButton *)sender {
    self.orangeView.layer.anchorPoint = CGPointMake(sender.selected * 0.5, sender.selected * 0.5);
    sender.selected = !sender.selected;
    NSLog(@"orange:%@---%@---%@----%@", NSStringFromCGRect(self.orangeView.frame), NSStringFromCGRect(self.orangeView.bounds), NSStringFromCGPoint(self.orangeView.center), NSStringFromCGPoint(self.orangeView.layer.position));
    NSLog(@"blueView:%@---%@---%@----%@", NSStringFromCGRect(self.blueView.frame), NSStringFromCGRect(self.blueView.bounds), NSStringFromCGPoint(self.blueView.center), NSStringFromCGPoint(self.blueView.layer.position));
}
@end
