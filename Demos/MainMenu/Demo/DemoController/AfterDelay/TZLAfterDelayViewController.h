//
//  TZLAfterDelayViewController.h
//  Demos
//
//  Created by tang on 2018/11/27.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZLAfterDelayViewController : ViewController
/**
 0 perform selector方法,
 1 GCD dispatch_after方法,
 2 UIView动画实现延时,
 3 NSThread sleep方法,
 4 NSTime 定时器方法,
 */
@property(nonatomic, assign) NSInteger index;
@end

NS_ASSUME_NONNULL_END
