//
//  UINavigationController+TZLExtension.h
//  DemoSet
//
//  Created by tang on 2018/9/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (TZLExtension)
/**
 *  @author tzl, 18-09-05 16:14:24
 *
 *  navigationBar's background alpha, when 0 your navigationBar will be invisable, default is 1. Animatable
 */
@property (nonatomic, assign) CGFloat tzl_navigationBarBackgroundAlpha NS_AVAILABLE_IOS(7_0);
@end
