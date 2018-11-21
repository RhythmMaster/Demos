//
//  TZLStudyNaviViewController.m
//  Demos
//
//  Created by tang on 2018/11/19.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLStudyNaviViewController.h"

@interface TZLStudyNaviViewController ()<UIScrollViewDelegate>
/**  */
@property(nonatomic, assign) UIStatusBarStyle barStyle;
/**  */
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation TZLStudyNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.barStyle = UIStatusBarStyleLightContent;
    self.barStyleBySelf = YES;
    
    UIButton *changeBarStyleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:changeBarStyleBtn];
    [changeBarStyleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
    [changeBarStyleBtn setTitle:@"改变电池条颜色" forState:UIControlStateNormal];
    [changeBarStyleBtn addTarget:self action:@selector(changeBarStyleAction:) forControlEvents:UIControlEventTouchUpInside];
    

    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.barStyle;
}
#pragma mark method action
- (void)changeBarStyleAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.barStyle = sender.selected ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    NSLog(@"self.scrollView.contentOffset.x = %f, self.scrollView.contentOffset.y = %f",self.scrollView.contentOffset.x,self.scrollView.contentOffset.y);
    
    NSLog(@"self.scrollView.bounds.origin.x = %f, self.scrollView.bounds.origin.y = %f",self.scrollView.bounds.origin.x,self.scrollView.bounds.origin.y);
    
    NSLog(@"********************************************************************************************");
}
@end
