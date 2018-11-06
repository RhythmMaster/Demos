//
//  TYCViewController.m
//  Demos
//
//  Created by tang on 2018/10/23.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TYCViewController.h"

@interface TYCViewController ()

@end

@implementation TYCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url =[NSURL URLWithString:@"https://www.tianyancha.com/search/os1-la1-ot1?base=wlmq"];
    NSURLSession *session =[NSURLSession sharedSession];
//    __weak typeof(self)temp =self;
    NSURLSessionDataTask *dataTask =[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"html = %@",retStr);
    }];
    [dataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
