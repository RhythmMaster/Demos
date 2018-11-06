//
//  TZLAddVCAnimatedTransitioning.m
//  Demos
//
//  Created by tang on 2018/11/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLAddVCAnimatedTransitioning.h"

@implementation TZLAddVCAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toViewController.view];
    
    CGRect originalRect = fromViewController.view.bounds;
    CGRect fromViewToRect = [transitionContext finalFrameForViewController:fromViewController];
    CGRect toViewFromRect = [transitionContext initialFrameForViewController:toViewController];
    
    fromViewController.view.frame = originalRect;
    toViewController.view.frame = toViewFromRect;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:0.5 options:0x00 animations:^{
        fromViewController.view.frame = fromViewToRect;
        toViewController.view.frame = originalRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
