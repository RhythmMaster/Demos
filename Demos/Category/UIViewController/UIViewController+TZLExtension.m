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
- (void)setChangeBtn:(UIButton *)changeBtn {
    objc_setAssociatedObject(self, @selector(changeBtn), changeBtn, OBJC_ASSOCIATION_RETAIN);
    
}
- (UIButton *)changeBtn {
    UIButton *button = objc_getAssociatedObject(self, @selector(changeBtn));
    if (!button) {
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:button];
        button.frame = CGRectMake(0, 0, 300, 60);
        button.center = CGPointMake(kScreenW * 0.5, kScreenH - 100);
        [button setTitle:@"改变点东西看看" forState:UIControlStateNormal];
        objc_setAssociatedObject(self, @selector(changeBtn), button, OBJC_ASSOCIATION_RETAIN);
    }
    return button;
}
@end
