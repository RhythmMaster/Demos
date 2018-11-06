//
//  TZLAddVCContextTransitioning.m
//  Demos
//
//  Created by tang on 2018/11/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLAddVCContextTransitioning.h"

@interface TZLAddVCContextTransitioning()
/**  */
@property(nonatomic, assign) CGRect viewDisapperFromRect;
/**  */
@property(nonatomic, assign) CGRect viewDisapperToRect;
/**  */
@property(nonatomic, assign) CGRect viewApperFromRect;
/**  */
@property(nonatomic, assign) CGRect viewApperToRect;
/**  */
@property(nonatomic, strong) NSDictionary *privateViewControllers;

/**  */
@property(nonatomic, strong) UIView *conView;
@end

@implementation TZLAddVCContextTransitioning
- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight {
    if (self = [super init]) {
        
        self.privateViewControllers = @{UITransitionContextFromViewControllerKey: fromViewController,
                                        UITransitionContextToViewControllerKey: toViewController
                                        };
        
        self.conView = fromViewController.view.superview;
        self.viewDisapperFromRect = self.viewApperToRect = self.conView.bounds;
        CGFloat travelDistance = goingRight ? self.conView.bounds.size.width : -self.conView.bounds.size.width;
        self.viewDisapperToRect = CGRectOffset(self.conView.bounds, -travelDistance, 0);
        self.viewApperFromRect = CGRectOffset(self.conView.bounds, travelDistance, 0);
    }
    return self;
}
- (CGRect)initialFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.viewDisapperFromRect;
    } else {
        return self.viewApperFromRect;
    }
}
- (CGRect)finalFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.viewDisapperToRect;
    } else {
        return self.viewApperToRect;
    }
}
- (UIViewController *)viewControllerForKey:(UITransitionContextViewControllerKey)key {
    return self.privateViewControllers[key];
}
- (void)completeTransition:(BOOL)didComplete {
    if (self.completionBlock) {
        self.completionBlock(didComplete);
    }
}
- (UIView *)containerView {
    return self.conView;
}
- (UIModalPresentationStyle)presentationStyle {
    return UIModalPresentationCustom;
}

- (BOOL)transitionWasCancelled { return NO; } // Our non-interactive transition can't be cancelled (it could be interrupted, though)

// Supress warnings by implementing empty interaction methods for the remainder of the protocol:

- (void)updateInteractiveTransition:(CGFloat)percentComplete {}
- (void)finishInteractiveTransition {}
- (void)cancelInteractiveTransition {}

- (nullable __kindof UIView *)viewForKey:(nonnull UITransitionContextViewKey)key {
    if (key == UITransitionContextFromViewKey) {
        return [self viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    } else {
        return [self viewControllerForKey:UITransitionContextToViewControllerKey].view;
    }
}



@synthesize animated;

@synthesize interactive;

@synthesize targetTransform;

@end
