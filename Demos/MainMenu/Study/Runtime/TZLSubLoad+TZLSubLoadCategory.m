//
//  TZLSubLoad+TZLSubLoadCategory.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLSubLoad+TZLSubLoadCategory.h"

@implementation TZLSubLoad (TZLSubLoadCategory)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
        SEL oriSEL = @selector(testLoad1);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
//        IMP imp = method_getImplementation(oriMethod);
        
        SEL cusSEL = @selector(tzl_swizzTestLoad1);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
            
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
        
    });
    
}

- (void)tzl_swizzTestLoad1 {
    NSLog(@"%s", __func__);
    NSLog(@"------------分割线------------");
    [self tzl_swizzTestLoad1];
}
@end
