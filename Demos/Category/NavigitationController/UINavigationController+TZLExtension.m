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
    [self.navigationBar navBarAlpha:tzl_navigationBarBackgroundAlpha isOpaque:YES];
}
- (CGFloat)tzl_navigationBarBackgroundAlpha {
    MyNavView *naviBackView = self.navigationBar.myNavView;
    return naviBackView.alpha;
}
@end
