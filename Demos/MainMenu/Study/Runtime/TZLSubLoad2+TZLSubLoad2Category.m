//
//  TZLSubLoad2+TZLSubLoad2Category.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLSubLoad2+TZLSubLoad2Category.h"

@implementation TZLSubLoad2 (TZLSubLoad2Category)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
        SEL oriSEL = @selector(testLoad);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        SEL cusSEL = @selector(tzl_swizzTestLoad2);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
    
    });
    
}

- (void)tzl_swizzTestLoad2 {
    NSLog(@"%s", __func__);
    NSLog(@"------------分割线------------");
    [self tzl_swizzTestLoad2];
}
@end
