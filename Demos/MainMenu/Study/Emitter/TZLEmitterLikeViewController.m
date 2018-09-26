//
//  TZLEmitterLikeViewController.m
//  Demos
//
//  Created by tang on 2018/9/21.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLEmitterLikeViewController.h"
#import "TZLLikeButton.h"

@interface TZLEmitterLikeViewController ()

@end

@implementation TZLEmitterLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    TZLLikeButton *likeBtn = [TZLLikeButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:likeBtn];
    likeBtn.frame = CGRectMake(100, 100, 30, 130);
    [self.view addSubview:likeBtn];
    [likeBtn setImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"liek_orange"] forState:UIControlStateSelected];
    [likeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnClick:(UIButton *)button{
    
    if (!button.selected) { // 点赞
        button.selected = !button.selected;
        NSLog(@"点赞");
    }else{ // 取消点赞
        button.selected = !button.selected;
        NSLog(@"取消赞");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
