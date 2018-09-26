//
//  MKJPresentAnimator.m
//  RedBookTransitionDemo
//
//  Created by 宓珂璟 on 2016/11/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "MKJPresentAnimator.h"
//#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface MKJPresentAnimator ()

@end

@implementation MKJPresentAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.45f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 这个是present的动画
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    UIView *fromView = [fromViewController.view viewWithTag:1111];
    __block UIView *snapShotView = [fromView snapshotViewAfterScreenUpdates:NO];
    // 这里present不和push一样需要自己标记，这里直接有跟踪标记
    if (toViewController.beingPresented) {
        // toView加进来，设置居中的小框
        snapShotView.frame = CGRectMake(100, 100, 250, 500);
        [containerView addSubview:toView];
        [containerView addSubview:snapShotView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapShotView.frame = CGRectMake(160, 160, 120, 250);
        } completion:^(BOOL finished) {
            [snapShotView removeFromSuperview];
            snapShotView = nil;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    } else {
        snapShotView.frame = CGRectMake(160, 160, 120, 250);
//        [containerView addSubview:toView];//不能加 加了就黑屏 我猜是因为toView已经消失了导致的
        [containerView addSubview:snapShotView];
        // 返回的时候直接放fromView动画缩小就行了，提交之后自动消失了
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            snapShotView.frame = CGRectMake(100, 100, 250, 500);
            
        } completion:^(BOOL finished) {
           
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
}


@end
