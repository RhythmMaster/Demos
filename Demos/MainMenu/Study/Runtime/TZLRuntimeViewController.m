//
//  TZLRuntimeViewController.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLRuntimeViewController.h"
#import <objc/runtime.h>

#import "TZLSubLoad.h"
#import "TZLSubLoad2.h"
#import "TZLSubLoad3.h"

@interface TZLRuntimeViewController ()

@end

@implementation TZLRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.index == 0) {
        [self runtimeOne];
    }
    if (self.index == 3) {
        [self addMethodOne];
    }
    if (self.index == 4) {
        [self addMethodTwo];
    }
    if (self.index == 5) {
        [self replaceMethodOne];
    }
    if (self.index == 6) {
        [self loadOne];
    }
    if (self.index == 7) {
        [self loadTwo];
    }
    if (self.index == 8) {
        [self loadThree];
    }
    if (self.index == 9) {
        [self loadFour];
    }
}

- (void)runtimeOne {
    Method onlyImpMethod = class_getInstanceMethod([self class], @selector(onlyImpMethod));
    
    Method impAndSelectorMethod = class_getInstanceMethod([self class], @selector(impAndSelectorMethod));
    
    Method onlySelectorMethod = class_getInstanceMethod([self class], @selector(onlySelectorMethod));
    
    Method noMethod = class_getInstanceMethod([self class], @selector(noMethod));
    
    method_exchangeImplementations(onlyImpMethod, impAndSelectorMethod);
    
//    method_exchangeImplementations(onlySelectorMethod, noMethod);
    
    [self onlyImpMethod];
    [self impAndSelectorMethod];
    
    [self onlySelectorMethod];
}


#pragma mark method class_getInstanceMethod
- (void)onlyImpMethod {
    NSLog(@"我只有实现,没有声明");
}
- (void)impAndSelectorMethod {
    NSLog(@"我既有声明,又有实现");
}
- (void)noMethod {
    NSLog(@"如果我被调用了,说明什么");
}
- (void)imSuper {
    NSLog(@"我是父类");
}

#pragma mark method class_addMethod
- (void)addMethodOne {
    Method addMethod1 = class_getInstanceMethod([self class], @selector(addMethod1));
    
    Method addMethod2 = class_getInstanceMethod([self class], @selector(addMethod2));
    
    BOOL success = class_addMethod([self class], @selector(addMethod1), method_getImplementation(addMethod2), method_getTypeEncoding(addMethod2));
    NSLog(@"-----%d----", success);
    [self addMethod1];
}
- (void)addMethodTwo {
    Method addMethod1 = class_getInstanceMethod([self class], @selector(addMethod3));
    
    Method addMethod2 = class_getInstanceMethod([self class], @selector(addMethod3To1));
    
    BOOL success = class_addMethod([self class], @selector(addMethod3), method_getImplementation(addMethod2), method_getTypeEncoding(addMethod2));
    NSLog(@"-----%d----", success);
    [self addMethod3];
    [self addMethod3To1];
}
- (void)addMethod1 {
    NSLog(@"我是%s", __func__);
}
- (void)addMethod2 {
    NSLog(@"我是%s", __func__);
}
- (void)addMethod3To1 {
    NSLog(@"我是%s", __func__);
}

#pragma mark method class_replaceMethod
- (void)replaceMethodOne {
    Method addMethod1 = class_getInstanceMethod([self class], @selector(addMethod4));
    
    Method addMethod2 = class_getInstanceMethod([self class], @selector(addMethod4To1));
    
    Method addMethod3 = class_getInstanceMethod([self class], @selector(addMethod4To3));
    
    BOOL success = class_addMethod([self class], @selector(addMethod4), method_getImplementation(addMethod2), method_getTypeEncoding(addMethod2));
    if (success) {
        class_replaceMethod([self class], @selector(addMethod4To1), method_getImplementation(addMethod1), method_getTypeEncoding(addMethod1));
    }
    [self addMethod4];
    [self addMethod4To1];
    
    class_replaceMethod([self class], @selector(addMethod4To2), method_getImplementation(addMethod3), method_getTypeEncoding(addMethod1));
    [self addMethod4To2];
    [self addMethod4To3];
}
//- (void)addMethod4 {
//    NSLog(@"我是%s", __func__);
//}
- (void)addMethod4To1 {
    NSLog(@"我是%s", __func__);
}
- (void)addMethod4To2 {
    NSLog(@"我是%s", __func__);
}
- (void)addMethod4To3 {
    NSLog(@"我是%s", __func__);
}

- (void)loadOne {
    TZLLoad *load = [TZLLoad new];
    [load testLoad];
}

- (void)loadTwo {
    TZLSubLoad *load = [TZLSubLoad new];
    [load testLoad1];
}
- (void)loadThree {
    TZLSubLoad2 *load = [TZLSubLoad2 new];
    [load testLoad];
}
- (void)loadFour {
    TZLSubLoad3 *load = [TZLSubLoad3 new];
    [load testLoad3];
    [load imp1];
    [load imp2];
}
@end
