//
//  TZLAfterDelayViewController.m
//  Demos
//
//  Created by tang on 2018/11/27.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLAfterDelayViewController.h"

@interface TZLAfterDelayViewController ()
/**  */
@property(nonatomic, strong) UIView *colorView;
/**  */
@property(nonatomic, strong) NSTimer *timer;
@end

@implementation TZLAfterDelayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.index == 0) {
        [self delayMethodOne];
    }
    
    if (self.index == 1) {
        [self delayMethodTwo];
    }
    
    if (self.index == 2) {
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 60, 60)];
        [self.view addSubview:colorView];
        colorView.backgroundColor = [UIColor orangeColor];
        self.colorView = colorView;
        [self delayMethodThree];
    }
    
    if (self.index == 3) {
        [self delayMethodFour];
    }
    
    if (self.index == 4) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(50, 100, 260, 60);
        [button setTitle:@"取消NSTimer的延时操作" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelNSTimerDelay) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self delayMethodFive];
    }
}

//FIXME:perform selector方法
/**
 perform selector方法
 这个方法有个优点就是不会阻塞线程。此方式要求必须在主线程中执行，否则无效，没有取消的方法
 */
- (void)delayMethodOne {
    NSLog(@"%@", [NSDate date]);
    [self performSelector:@selector(delayMethodOneAction) withObject:nil afterDelay:2];
}

//FIXME:GCD dispatch_after方法
/**
    GCD dispatch_after方法
    GCD中dispatch_after方法也可以实现延迟。而且不会阻塞线程，效率较高（推荐使用），并且可以在参数中选择执行的线程，同样没有可取消的方法
 */
- (void)delayMethodTwo{
    NSLog(@"%@", [NSDate date]);
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self delayMethodOneAction];
    });
}

//FIXME:UIView动画实现延时
/**
 UIView动画实现延时
 UIview动画延迟是不会阻塞线程的
 */
- (void)delayMethodThree{
    NSLog(@"%@", [NSDate date]);
    [UIView animateWithDuration:2 delay:3 options:UIViewAnimationOptionCurveLinear animations:^{
        self.colorView.transform = CGAffineTransformMakeTranslation(0, 100);
    } completion:^(BOOL finished) {
        NSLog(@"%@", [NSDate date]);
    }];
}

//FIXME:NSThread sleep方法
/**
 NSThread sleep方法
 这个方法也可以实现延时，其实就是让该线程睡眠一段时间，所以它一定会阻塞线程，浪费资源，所以一般是不推荐使用的。它没有取消的方法，可以放在主线程或者子线程中，如果一定要用还是建议放在子线程中防止卡顿界面。
 */
- (void)delayMethodFour {
    NSLog(@"%@", [NSDate date]);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        sleep(5);
        NSLog(@"%@", [NSDate date]);
        NSLog(@"这是啥线程---%@", [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"这是啥线程---%@", [NSThread currentThread]);
            NSLog(@"%@", [NSDate date]);
        });
    });
    NSLog(@"这是主线程---%@", [NSThread currentThread]);
}

//FIXME:NSTime 定时器方法
/**
 NSTime 定时器方法
 定时器NSTimer也可以实现延迟，是一种非阻塞的执行方式。取消的话可以先判断isInvalidate然后调用invalidate取消该定时器
 */
- (void)delayMethodFive {
    NSLog(@"%@", [NSDate date]);
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(delayMethodOneAction) userInfo:nil repeats:NO];
    self.timer = timer;
}

- (void)cancelNSTimerDelay {
    if (self.timer.valid) {
        [self.timer invalidate];
    }
}

- (void)delayMethodOneAction {
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"%@", [NSDate date]);
}
@end
