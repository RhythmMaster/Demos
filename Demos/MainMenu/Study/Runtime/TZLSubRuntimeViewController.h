//
//  TZLSubRuntimeViewController.h
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLRuntimeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZLSubRuntimeViewController : TZLRuntimeViewController
/**
 1 父类有实现,但是没声明class_getInstanceMethod()函数能否取到/n结论: 有点奇怪,先子类,再父类
 2 父类有实现,有声明class_getInstanceMethod()函数能否取到
 */
@property(nonatomic, assign) NSInteger index;
@end

NS_ASSUME_NONNULL_END
