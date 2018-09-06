//
//  UINavigationController+TZLExtension.m
//  DemoSet
//
//  Created by tang on 2018/9/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "UINavigationController+TZLExtension.h"

@implementation UINavigationController (TZLExtension)
- (void)setTzl_navigationBarBackgroundAlpha:(CGFloat)tzl_navigationBarBackgroundAlpha {
    UIView *naviBackView = [self.navigationBar valueForKey:@"_backgroundView"];
    naviBackView.alpha = tzl_navigationBarBackgroundAlpha;
}
- (CGFloat)tzl_navigationBarBackgroundAlpha {
    UIView *naviBackView = [self.navigationBar valueForKey:@"_backgroundView"];
    return naviBackView.alpha;
}
@end
