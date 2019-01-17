//
//  TZLSubLoad3+TZLSubLoad3Category.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLSubLoad3+TZLSubLoad3Category.h"

@implementation TZLSubLoad3 (TZLSubLoad3Category)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
        SEL oriSEL = @selector(testLoad3);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        SEL cusSEL = @selector(tzl_swizzTestLoad3);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            IMP oriIMP = method_getImplementation(oriMethod);
            IMP replaceIMP = class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
            class_addMethod(selfClass, @selector(imp1), oriIMP, method_getTypeEncoding(class_getInstanceMethod(selfClass, @selector(imp1))));
            class_addMethod(selfClass, @selector(imp2), replaceIMP, method_getTypeEncoding(class_getInstanceMethod(selfClass, @selector(imp2))));
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
        
    });
    
}

- (void)tzl_swizzTestLoad3 {
    NSLog(@"%s", __func__);
    NSLog(@"------------分割线------------");
    [self tzl_swizzTestLoad3];
}
@end
