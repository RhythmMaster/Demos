//
//  TZLCustomTransformAnimation.m
//  Demos
//
//  Created by tang on 2018/9/26.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLCustomTransformAnimation.h"
@interface TZLCustomTransformAnimation()
/**  */
@property(nonatomic, assign) BOOL isPush;
/**  */
@property(nonatomic, strong) UIView *animationView;
/**  */
@property(nonatomic, assign) CGRect fromFrame;
/**  */
@property(nonatomic, assign) CGRect toFrame;
@end

@implementation TZLCustomTransformAnimation
- (instancetype)initAnimationWithIsPush:(BOOL)isPush animationView:(UIView *)animationView fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame {
    if (self = [super init]) {
        self.isPush = isPush;
        self.animationView = animationView;
        self.fromFrame = fromFrame;
        self.toFrame = toFrame;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    containerView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:toVC.view];
    if (self.isPush) {
        toVC.view.hidden = YES;
        fromVC.view.hidden = YES;
    } else {
        self.animationView.hidden = YES;
    }
    __block UIView *snapShotView = [self.animationView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = self.isPush ? self.fromFrame : self.toFrame;
    [containerView addSubview:snapShotView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        snapShotView.frame = self.isPush ? self.toFrame : self.fromFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [snapShotView removeFromSuperview];
        snapShotView = nil;
        toVC.view.hidden = NO;
        fromVC.view.hidden = NO;
        self.animationView.hidden = NO;
    }];
}
@end
