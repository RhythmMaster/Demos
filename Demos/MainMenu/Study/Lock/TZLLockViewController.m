//
//  TZLLockViewController.m
//  Demos
//
//  Created by tang on 2018/11/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLLockViewController.h"
#import "libkern/OSAtomic.h"

@interface TZLLockViewController ()

@end

@implementation TZLLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.index == 0) {
        [self lockOne];
    }
    if (self.index == 1) {
        [self lockTwo];
    }
    if (self.index == 2) {
        [self lockThree];
    }
    if (self.index == 3) {
        [self lockFour];
    }
    if (self.index == 4) {
        [self lockFive];
    }
    if (self.index == 5) {
        [self lockSix];
    }
    if (self.index == 6) {
        [self lockSeven];
    }
    if (self.index == 7) {
        [self lockEight];
    }
    if (self.index == 8) {
        [self lockNine];
    }
}

/**
一、OSSpinLock自旋锁
 自旋锁不会让等待的进入睡眠状态，直到线程1的任务执行完且解锁完毕，线程2才会执行
 如果线程1不解锁,那么线程2锁后面的内容都不会执行
 */
- (void)lockOne {
    __block OSSpinLock osspinLock = OS_SPINLOCK_INIT;
    __block NSInteger num = 10;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1准备上锁");
        OSSpinLockLock(&osspinLock);
        NSLog(@"我是线程1%@", [NSThread currentThread]);
        num += 1;
        NSLog(@"num: %ld", num);
        OSSpinLockUnlock(&osspinLock);
        NSLog(@"线程1已经解锁");
        
    });
    NSLog(@"我是分割线--------------");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2准备上锁");
        OSSpinLockLock(&osspinLock);
        NSLog(@"我是线程2%@", [NSThread currentThread]);
        num -= 1;
        NSLog(@"num: %ld", num);
        OSSpinLockUnlock(&osspinLock);
        NSLog(@"线程2已经解锁");
    });
}

/**
二、dispatch_semaphore 信号量
 */
- (void)lockTwo {
    //必须传入 >=1 的数字 ,如果传入0,会阻塞线程,但是会在等待时间结束后执行, 传入的数字相当于能同时进行的数量 1 表示 只能1件事情进行,达到 锁的目的
    dispatch_semaphore_t single = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    __block NSInteger num = 10;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"我是线程1,正在等待信号:%@", [NSThread currentThread]);
        //signal值 -1
        dispatch_semaphore_wait(single, overTime);
        NSLog(@"我是线程1,我等到了信号:%@", [NSThread currentThread]);
        num += 1;
        NSLog(@"num: %ld", num);
        //signal值 +1
        dispatch_semaphore_signal(single);
        NSLog(@"我是线程1,我将信号发送了出去:%@", [NSThread currentThread]);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"我是线程2,正在等待信号:%@", [NSThread currentThread]);
        //signal值 -1
        dispatch_semaphore_wait(single, overTime);
        NSLog(@"我是线程2,我等到了信号:%@", [NSThread currentThread]);
        num -= 1;
        NSLog(@"num: %ld", num);
        //signal值 +1
        dispatch_semaphore_signal(single);
        NSLog(@"我是线程2,我将信号发送了出去:%@", [NSThread currentThread]);
    });
}

/**
    pthread_mutex 互斥锁
 */
- (void)lockThree {
    static pthread_mutex_t mutexLock;
    pthread_mutex_init(&mutexLock, NULL);
    
    __block NSInteger num = 10;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"我是线程1,我准备上锁了%@", [NSThread currentThread]);
        pthread_mutex_lock(&mutexLock);
        num += 1;
        NSLog(@"我是线程1,我上锁成功了.并且 num = %ld", num);
        NSLog(@"我是线程1,我准备解锁锁了%@", [NSThread currentThread]);
        pthread_mutex_unlock(&mutexLock);
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"我是线程2,我准备上锁了%@", [NSThread currentThread]);
        pthread_mutex_lock(&mutexLock);
        num -= 1;
        NSLog(@"我是线程2,我上锁成功了.并且 num = %ld", num);
        NSLog(@"我是线程2,我准备解锁锁了%@", [NSThread currentThread]);
        pthread_mutex_unlock(&mutexLock);
        
    });
    
    NSLog(@"我是主线程,我准备上锁了%@", [NSThread currentThread]);
    pthread_mutex_lock(&mutexLock);
    num = 20;
    NSLog(@"我是主线程,我上锁成功了.并且 num = %ld", num);
    NSLog(@"我是主线程,我准备解锁锁了%@", [NSThread currentThread]);
    pthread_mutex_unlock(&mutexLock);
}

/**
 根据上面讲述的几个锁，可以发现：加锁后只能有一个线程访问该对象，后面的线程需要排队，并且lock与unlock都是对应出现的，同一线程多次lock是不允许的，而递归锁允许同一个线程在未释放其拥有的锁时反复对该锁进行加锁操作。
 */
- (void)lockFour {
    static pthread_mutex_t pLock;
    pthread_mutexattr_t attr;
    //初始化attr并且给它赋予默认
    pthread_mutexattr_init(&attr);
    //设置锁类型，这边是设置为递归锁
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&pLock, &attr);
    //销毁一个属性对象，在重新进行初始化之前该结构不能重新使用
    pthread_mutexattr_destroy(&attr);
    
    //1.线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value) {
            pthread_mutex_lock(&pLock);
            if (value > 0) {
                NSLog(@"value = %d", value);
                NSLog(@"线程 = ，%@",[NSThread currentThread]);
                RecursiveBlock(value - 1);
            }
            pthread_mutex_unlock(&pLock);
        };
        RecursiveBlock(5);
    });
    dispatch_async(dispatch_queue_create("waitqueue", DISPATCH_QUEUE_CONCURRENT), ^{
        NSLog(@"我先睡个2秒钟");
        sleep(2);
        NSLog(@"2秒钟后....: 恩,我睡醒了,该干活了");
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"前面的递归做的不错,没把global_queue给锁死,我还能逼逼一会");
        });
    });
    
}
/**
 lock、unlock：不多做解释，和上面一样。
 trylock：能加锁返回 YES 并执行加锁操作，相当于 lock，反之返回 NO。
 lockBeforeDate：这个方法表示会在传入的时间内尝试加锁，若能加锁则执行加锁操作并返回 YES，反之返回 NO。
 */
- (void)lockFive {
    NSLock *lock = [NSLock new];
    int __block num = 10;
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 尝试加锁ing...");
        [lock lock];
        num = num + 1;
        NSLog(@"num1=%d",num);
        NSLog(@"线程1");
        NSLog(@"线程1解锁成功");
        [lock unlock];
        
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 尝试加锁ing...");
        BOOL x =  [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:4]];
        if (x) {
            NSLog(@"线程2");
            num = num + 1;
            NSLog(@"num2=%d",num);
            NSLog(@"线程2解锁成功");
            [lock unlock];
        }else{
            NSLog(@"失败");
        }
    });
    
}
/**
 wait：进入等待状态
 waitUntilDate:：让一个线程等待一定的时间
 signal：唤醒一个等待的线程
 broadcast：唤醒所有等待的线程
 */
- (void)lockSix {
    NSCondition *cLock = [NSCondition new];
    int __block num = 10;
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程1加锁成功");
        [cLock wait];
        NSLog(@"线程1--%@",[NSThread currentThread]);
        num = num + 1;
        NSLog(@"num1=%d",num);
        NSLog(@"线程1解锁");
        [cLock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程2加锁成功");
        [cLock wait];
        NSLog(@"线程2--%@",[NSThread currentThread]);
        num = num + 1;
        NSLog(@"num2=%d",num);
        NSLog(@"线程2解锁");
        [cLock unlock];
    });
    
    //线程3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程3加锁成功");
        [cLock wait];
        NSLog(@"线程3--%@",[NSThread currentThread]);
        num = num + 1;
        NSLog(@"num3=%d",num);
        NSLog(@"线程3解锁");
        [cLock unlock];
    });
    
    //线程4
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程4加锁成功");
        [cLock wait];
        NSLog(@"线程4--%@",[NSThread currentThread]);
        num = num + 1;
        NSLog(@"num4=%d",num);
        NSLog(@"线程4解锁");
        [cLock unlock];
    });
    
    //线程5
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程5start");
        [cLock lock];
        [cLock waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
        num = num + 1;
        NSLog(@"num=%d",num);
        NSLog(@"线程5");
        [cLock unlock];
    });
    
    dispatch_async(dispatch_queue_create("waitQueue1", DISPATCH_QUEUE_CONCURRENT), ^{
        sleep(1);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"唤醒一个等待的线程");
            [cLock signal];
        });
    });
    
    dispatch_async(dispatch_queue_create("waitQueue2", DISPATCH_QUEUE_CONCURRENT), ^{
        sleep(5);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"唤醒所有等待的线程");
            [cLock broadcast];
        });
    });
    
}
/**
 在下面这种情况下 ,由于 第一次 传入 4 的时候线程加锁了,再次传入3的时候,发现是锁住的 ,该线程就会一直等待下去 ,无法解锁,导致锁死
 可以换成 递归锁  NSRecursiveLock * nsLock = [[NSRecursiveLock alloc] init];
 */
- (void)lockSeven {
    NSLock *nsLock = [[NSLock alloc] init];
//    NSRecursiveLock * nsLock = [[NSRecursiveLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value) {
            [nsLock lock];
            if (value > 0) {
                NSLog(@"线程%d", value);
                RecursiveBlock(value - 1);
            }
            [nsLock unlock];
        };
        RecursiveBlock(4);
    });
//    dispatch_async(dispatch_queue_create("waitqueue", DISPATCH_QUEUE_CONCURRENT), ^{
//        NSLog(@"我先睡个2秒钟");
//        sleep(2);
//        NSLog(@"2秒钟后....: 恩,我睡醒了,该干活了,不知道我能不能在后面再global_queue里说话呢");
//        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSLog(@"前面的递归做的不错,没把global_queue给锁死,我还能出来逼逼");
//        });
//        sleep(2);
//        NSLog(@"我在global_queue里的话没说出来,很难受,上面那逼把global_queue锁死了");
//    });
}
- (void)lockEight {
    __block NSInteger num = 10;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            NSLog(@"线程1");
            num += 1;
            NSLog(@"%ld", num);
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            NSLog(@"线程2");
            num -= 1;
            NSLog(@"%ld", num);
        }
    });
}
- (void)lockNine {
    __block NSInteger num = 10;
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:2];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:0];
        NSLog(@"线程1加锁成功");
        NSLog(@"线程1--%@",[NSThread currentThread]);
        num = num + 1;
        NSLog(@"num=%ld",num);
        NSLog(@"线程1解锁");
        [lock unlockWithCondition:1];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:2];
        NSLog(@"线程2加锁成功");
        NSLog(@"线程2--%@",[NSThread currentThread]);
        num = num + 1;
        NSLog(@"num=%ld",num);
        NSLog(@"线程2解锁");
        [lock unlockWithCondition:0];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:1];
        NSLog(@"线程3加锁成功");
        NSLog(@"线程3--%@",[NSThread currentThread]);
        num = num + 1;
        NSLog(@"num=%ld",num);
        NSLog(@"线程3解锁");
        [lock unlockWithCondition:5];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:4];
        NSLog(@"线程4加锁成功");
        NSLog(@"线程4--%@",[NSThread currentThread]);
        num = num + 1;
        NSLog(@"num=%ld",num);
        NSLog(@"线程4解锁");
        [lock unlockWithCondition:8];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:5];
        NSLog(@"线程5加锁成功");
        NSLog(@"线程5--%@",[NSThread currentThread]);
        num = num + 1;
        NSLog(@"num=%ld",num);
        NSLog(@"线程5解锁");
        [lock unlockWithCondition:7];
    });
}
@end
