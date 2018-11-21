//
//  UINavigationController+TZLExtension.m
//  DemoSet
//
//  Created by tang on 2018/9/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "UINavigationController+TZLExtension.h"
#import <objc/runtime.h>

static char endTransformAnimation_key;
@implementation UINavigationController (TZLExtension)
- (void)setEndTransformAnimation:(BOOL)endTransformAnimation {
    objc_setAssociatedObject(self, &endTransformAnimation_key, @(endTransformAnimation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)endTransformAnimation {
    return [objc_getAssociatedObject(self, &endTransformAnimation_key) boolValue];
}
@end
