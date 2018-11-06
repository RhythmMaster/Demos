//
//  TZLAddVCOneViewController.h
//  Demos
//
//  Created by tang on 2018/10/24.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "ViewController.h"
#import "TZLChildViewController.h"

@interface TZLAddVCOneViewController : ViewController

/**  */
@property(nonatomic, strong) UIViewController *selectedViewController;
/**  */
@property(nonatomic, strong) NSArray<UIViewController *> *childrenViewControllers;

/** 是否有动画 */
@property(nonatomic, assign) BOOL haveAnimate;

- (instancetype)initWithChildViewControllers:(NSArray<UIViewController *> *)childViewControllers;



@end
