//
//  UIViewController+TZLStatistics.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "UIViewController+TZLStatistics.h"

@implementation UIViewController (TZLStatistics)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
        SEL oriSEL = @selector(viewDidLoad);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        SEL cusSEL = @selector(tzl_statisticsViewDidLoad);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
        
    });
}
- (void)tzl_statisticsViewDidLoad {
    [self tzl_statisticsViewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger statisticsNum = [defaults integerForKey:[self className]];
    if ([[self className] containsString:@"Statistics"]) {
        statisticsNum++;
    }
    [defaults setInteger:statisticsNum forKey:[self className]];
    [defaults synchronize];
}
@end
