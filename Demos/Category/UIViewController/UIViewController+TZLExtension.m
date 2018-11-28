//
//  UIViewController+TZLExtension.m
//  DemoSet
//
//  Created by tang on 2018/9/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "UIViewController+TZLExtension.h"
#import <objc/runtime.h>

static NSString *backTitle = @"backTitle";
static NSString *tzl_topItem = @"TZLTopItem";

@implementation UIViewController (TZLExtension)
- (void)setChangeBackText:(NSString *)changeBackText {
    objc_setAssociatedObject(self, @selector(changeBackText), changeBackText, OBJC_ASSOCIATION_RETAIN);
    UIViewController *lastVC = nil;
    if (self.navigationController.viewControllers.count > 1) {
        if (!lastVC) {
            NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
            if (index > 1) {
                lastVC = [self.navigationController.viewControllers objectAtIndex:index - 1];
            }
        }
        if (lastVC) {
            lastVC.title = changeBackText;
        }
    }
}
- (NSString *)changeBackText {
    return objc_getAssociatedObject(self, @selector(changeBackText));
}

- (void)alertViewWithMessage:(NSString *)message {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:^{
        
        [NSThread sleepForTimeInterval:0.2];
        
        [alert dismissViewControllerAnimated:YES completion:nil];
        
        
    }];
    
    
}
@end
