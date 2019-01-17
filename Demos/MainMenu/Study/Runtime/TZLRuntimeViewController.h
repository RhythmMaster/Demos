//
//  TZLRuntimeViewController.h
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZLRuntimeViewController : UIViewController
/**
   0 @"只有方法实现,没有方法声明,class_getInstanceMethod()函数能否取到"
   3 class_addMethod,如果被替换的方法已经实现,则替换失败
 */
@property(nonatomic, assign) NSInteger index;

//我既有声明,又有实现
- (void)impAndSelectorMethod;
- (void)onlySelectorMethod;


- (void)addMethod3;

- (void)addMethod4;
@end

NS_ASSUME_NONNULL_END
