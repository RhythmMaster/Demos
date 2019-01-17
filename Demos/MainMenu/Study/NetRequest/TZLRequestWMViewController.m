//
//  TZLRequestWMViewController.m
//  Demos
//
//  Created by tang on 2019/1/7.
//  Copyright © 2019年 TZL. All rights reserved.
//

#import "TZLRequestWMViewController.h"
#import "TZLNetRequestViewController.h"
#import "TZLNSURLSessionViewController.h"
#import "TZLNetImageViewController.h"
#import "TZLUploadImageViewController.h"
#import "TZLDownloadViewController.h"

@interface TZLRequestWMViewController ()

@end

@implementation TZLRequestWMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"普通的网络请求", @"NSURLSession的各种代理", @"来张图片瞅瞅",
                     @"上传图片", @"下载"];
    self.controllerArr = @[[TZLNetRequestViewController class],
                           [TZLNSURLSessionViewController class],
                           [TZLNetImageViewController class],
                           [TZLUploadImageViewController class],
                           [TZLDownloadViewController class]];
}



@end
