//
//  NSObject+Tools.h
//  Demos
//
//  Created by tang on 2018/9/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Tools)
//获取对象所有变量
- (void)getIvars;
//获取对象所有属性
- (void)getPropertys;
@end
