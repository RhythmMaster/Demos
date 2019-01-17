//
//  TZLSubRuntimeViewController.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLSubRuntimeViewController.h"

@implementation TZLSubRuntimeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.index == 1) {
        [self runtimeOne];
    }
    if (self.index == 2) {
        [self runtimeTwo];
    }
}

- (void)runtimeOne {
    Method imSuper = class_getInstanceMethod([self class], @selector(imSuper));
    
    Method imSub = class_getInstanceMethod([self class], @selector(imSub));
    
    
    method_exchangeImplementations(imSuper, imSub);
    
    
    [self imSub];
    
    
    
}
- (void)runtimeTwo {
    Method impAndSelectorMethod = class_getInstanceMethod([self class], @selector(impAndSelectorMethod));
    
    Method imSubTwo = class_getInstanceMethod([self class], @selector(imSubTwo));
    
    
    method_exchangeImplementations(impAndSelectorMethod, imSubTwo);
    
    
    [self imSubTwo];
}
- (void)imSub {
    NSLog(@"我是子类");
}
- (void)imSubTwo {
    NSLog(@"我是子类2号");
}
@end
