//
//  UIViewController+TZLExtension.m
//  DemoSet
//
//  Created by tang on 2018/9/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "UIViewController+TZLExtension.h"


@implementation UIViewController (TZLExtension)
- (void)setTzl_navigationBarBackgroundAlpha:(CGFloat)tzl_navigationBarBackgroundAlpha {
    [self.navigationController setTzl_navigationBarBackgroundAlpha:tzl_navigationBarBackgroundAlpha];
    objc_setAssociatedObject(self, @selector(tzl_navigationBarBackgroundAlpha), @(tzl_navigationBarBackgroundAlpha), OBJC_ASSOCIATION_RETAIN);
}
- (CGFloat)tzl_navigationBarBackgroundAlpha {
    if (self.navigationController) {
        id _navigationBarBackgroundAlpha = objc_getAssociatedObject(self, @selector(tzl_navigationBarBackgroundAlpha));
        if (_navigationBarBackgroundAlpha) {
            return [_navigationBarBackgroundAlpha tzl_CGFloatValue];
        }
        return self.navigationController.tzl_navigationBarBackgroundAlpha;
    } else {
        return 1.f;
    }
}
@end
