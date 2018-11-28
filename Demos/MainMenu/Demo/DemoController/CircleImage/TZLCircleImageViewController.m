//
//  TZLCircleImageViewController.m
//  Demos
//
//  Created by tang on 2018/11/27.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLCircleImageViewController.h"
#import "UIImage+TZLCircleImage.h"

@interface TZLCircleImageViewController ()

@end

@implementation TZLCircleImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(100, 100, 100, 100);
    imageView.image = [[UIImage imageNamed:@"周姬-吴-弓"] circleImage];
    [self.view addSubview:imageView];
}



@end
