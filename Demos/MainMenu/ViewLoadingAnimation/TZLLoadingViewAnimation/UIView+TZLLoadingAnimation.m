//
//  UIView+TZLLoadingAnimation.m
//  Demos
//
//  Created by tang on 2018/11/8.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "UIView+TZLLoadingAnimation.h"
#import <objc/runtime.h>

@implementation UIView (TZLLoadingAnimation)
- (void)setAnimationStyle:(TZLViewLoadAnimationStyle)animationStyle {
    objc_setAssociatedObject(self, @selector(animationStyle), @(animationStyle), OBJC_ASSOCIATION_ASSIGN);
}
- (TZLViewLoadAnimationStyle)animationStyle {
    TZLViewLoadAnimationStyle style = [objc_getAssociatedObject(self, @selector(animationStyle)) integerValue];
    return style;
}
- (void)setAnimationMode:(TZLViewLoadAnimationMode)animationMode {
    objc_setAssociatedObject(self, @selector(animationMode), @(animationMode), OBJC_ASSOCIATION_ASSIGN);
}
- (TZLViewLoadAnimationMode)animationMode {
    TZLViewLoadAnimationMode mode = [objc_getAssociatedObject(self, @selector(animationMode)) integerValue];
    return mode;
}

- (void)setStartOrEndForSelfIsSuperView:(BOOL)startOrEndForSelfIsSuperView {
    objc_setAssociatedObject(self, @selector(startOrEndForSelfIsSuperView), @(startOrEndForSelfIsSuperView), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)startOrEndForSelfIsSuperView {
    BOOL style = [objc_getAssociatedObject(self, @selector(startOrEndForSelfIsSuperView)) boolValue];
    return style;
}
@end
