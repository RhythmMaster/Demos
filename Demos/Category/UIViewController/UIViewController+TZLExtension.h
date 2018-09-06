//
//  UIViewController+TZLExtension.h
//  DemoSet
//
//  Created by tang on 2018/9/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "UINavigationController+TZLExtension.h"
#import "NSNumber+TZLExtension.h"

@interface UIViewController (TZLExtension)
/**
 设置当前控制器导航栏透明度
 */
@property (nonatomic, assign) IBInspectable CGFloat tzl_navigationBarBackgroundAlpha;
@end
