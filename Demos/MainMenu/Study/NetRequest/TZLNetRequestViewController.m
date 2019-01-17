//
//  TZLNetRequestViewController.m
//  Demos
//
//  Created by tang on 2018/10/10.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLNetRequestViewController.h"

@interface TZLNetRequestViewController ()

@end

@implementation TZLNetRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=206526375,3753916315&fm=175&app=25&f=JPEG?w=640&h=960&s=C1F5536E8608155D2575F19A0300C095
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:@"http://123.56.146.142:8080/xwpx/student/app/version2_0/appTheme".tzl_URL];
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@---\n%@", data, response);
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%@", dict);
        }
        
    }];
    [task resume];
    
    UIImageView *image = [UIImageView new];
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.size.equalTo(CGSizeMake(200, 400));
    }];
    [image setShowActivityIndicatorView:YES];

    [image sd_setImageWithURL:@"https://imgsa.baidu.com/forum/w%3D580/sign=9340e8ac424a20a4311e3ccfa0539847/84c58b2f07082838cf666caab599a9014d08f164.jpg".tzl_URL placeholderImage:[UIImage imageNamed:@"1"] options:SDWebImageRefreshCached];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] createBarItemWithImageName:@"1" name:@"清理图片" target:self action:@selector(clerDisk:)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)clerDisk:(UIButton *)sender {
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
