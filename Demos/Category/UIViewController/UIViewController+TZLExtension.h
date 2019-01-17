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

/** 隐藏本页面返回文字.只保留箭头 */
@property(nonatomic, strong) NSString *changeBackText;

- (void)alertViewWithMessage:(NSString *)message;

/** 懒得写button */
@property(nonatomic, strong) UIButton *changeBtn;
@end
