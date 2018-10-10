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
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:@"http://123.56.146.142:8080/xwpx/login/getAppMessages".tzl_URL];
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@---\n%@", data, response);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@", dict);
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
