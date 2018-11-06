//
//  TZLChildViewController.m
//  Demos
//
//  Created by tang on 2018/10/24.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLChildViewController.h"

@interface TZLChildViewController ()
/**  */
@property(nonatomic, strong) UILabel *titleLb;
@end

@implementation TZLChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = self.backgroundColor;
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLb];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleLb attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleLb attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    titleLb.text = self.textTitle;
    titleLb.numberOfLines = 0;
    titleLb.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.titleLb = titleLb;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_contentSizeCategoryDidChangeWithNotification:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)_contentSizeCategoryDidChangeWithNotification:(NSNotification *)notification {
    self.titleLb.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [self.titleLb invalidateIntrinsicContentSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
