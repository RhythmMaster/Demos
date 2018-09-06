//
//  NSObject+Tools.m
//  Demos
//
//  Created by tang on 2018/9/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "NSObject+Tools.h"

@implementation NSObject (Tools)
- (void)getIvars {
    unsigned int count = 0;
    // 拷贝出所胡的成员变量列表
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        Ivar ivar = *(ivars + i);
        // 打印成员变量名字
        NSLog(@"变量名字:%s", ivar_getName(ivar));
        // 打印成员变量的数据类型
        NSLog(@"成员变量的数据类型:%s", ivar_getTypeEncoding(ivar));
    }
    // 释放
    free(ivars);
}
- (void)getPropertys {
    unsigned int a;
    objc_property_t * result = class_copyPropertyList(object_getClass(self), &a);
    for (unsigned int i = 0; i < a; i++) {
        objc_property_t o_t =  result[i];
        NSLog(@"属性的数据类型: %@", [NSString stringWithFormat:@"%s", property_getAttributes(o_t)]);
        NSLog(@"属性名字: %@", [NSString stringWithFormat:@"%s", property_getName(o_t)]);
    
    }
}
@end
