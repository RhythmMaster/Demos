//
//  UIViewController+TZLExtension.m
//  DemoSet
//
//  Created by tang on 2018/9/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "UIViewController+TZLExtension.h"


@implementation UIViewController (TZLExtension)

- (void)alertViewWithMessage:(NSString *)message {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:^{
        
        [NSThread sleepForTimeInterval:0.2];
        
        [alert dismissViewControllerAnimated:YES completion:nil];
        
        
    }];
    
    
}
@end
