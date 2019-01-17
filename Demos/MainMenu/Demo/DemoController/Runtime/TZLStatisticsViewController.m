//
//  TZLStatisticsViewController.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLStatisticsViewController.h"

@interface TZLStatisticsViewController ()

@end

@implementation TZLStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.index == 1) {
        [self beyondIndex];
    }
}

- (void)beyondIndex {
    NSArray *arr1 = @[@"熊爱明", @"夏红", @"红木", @"路达"];
    NSString *str1 = [arr1 objectAtIndex:3];
     NSLog(@"%@", str1);
    NSString *str2 = [arr1 objectAtIndex:4];
     NSLog(@"%@", str2);
//    NSString *str3 = arr1[5];
//    NSLog(@"%@", str3);
}

@end
