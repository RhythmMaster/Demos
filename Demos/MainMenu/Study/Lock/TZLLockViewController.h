//
//  TZLLockViewController.h
//  Demos
//
//  Created by tang on 2018/11/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TZLLockViewController : ViewController
/**
 @"一、OSSpinLock自旋锁",
 @"二、dispatch_semaphore 信号量",
 @"三、pthread_mutex 互斥锁",
 @"四、pthread_mutex(recursive) 递归锁",
 @"五、NSLock普通锁",
 @"六、NSCondition",
 @"七、synchronized 同步锁",
 @"八、NSConditionLock 条件锁"
 */
@property(nonatomic, assign) NSInteger index;
@end

NS_ASSUME_NONNULL_END
