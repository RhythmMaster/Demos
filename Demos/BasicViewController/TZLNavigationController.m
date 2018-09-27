//
//  TZLNavigationController.m
//  DemoSet
//
//  Created by tang on 2018/6/7.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TZLNavigationController.h"
#import "TZLCustomTransformAnimation.h"

@interface TZLNavigationController ()<UINavigationControllerDelegate>
/**  */
@property(nonatomic, assign) BOOL isPush;
/**  */
@property(nonatomic, strong) UIView *animationView;
/**  */
@property(nonatomic, assign) CGRect fromFrame;
/**  */
@property(nonatomic, assign) CGRect toFrame;
/**  */
@property(nonatomic, strong) UIScreenEdgePanGestureRecognizer *gestureRecognizer;
/** 返回手势是否有动画效果 */
@property(nonatomic, assign) BOOL backAnimation;
@end

@implementation TZLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark method public
- (void)validatePanGestureRecognizerWithAnimation:(BOOL)animation {
    self.backAnimation = animation;
    if (!self.gestureRecognizer) {
        [self setScreenEdgePanGestureRecognizer];
    }
}
- (void)invalidatePanGestureRecognizer {
    [self.view removeGestureRecognizer:self.gestureRecognizer];
}
#pragma mark method private
- (void)setScreenEdgePanGestureRecognizer {
    UIScreenEdgePanGestureRecognizer *gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    gestureRecognizer.edges = UIRectEdgeLeft;
    self.gestureRecognizer = gestureRecognizer;
    [self.view addGestureRecognizer:gestureRecognizer];
}
- (void)gestureAction:(UIScreenEdgePanGestureRecognizer *)recognizer {
    if (!self.backAnimation) {
        self.delegate = nil;
        return;
    }
    CGFloat progress = [recognizer translationInView:self.view].x / self.view.frame.size.width * 1.5;
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percentDriven = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.percentDriven updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.5) {
            self.delegate = nil;
            [self.percentDriven finishInteractiveTransition];
        }else{
            [self.percentDriven cancelInteractiveTransition];
        }
        self.percentDriven = nil;
    }
    
}
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    UIViewController* topVC = self.topViewController;
//    return [topVC preferredStatusBarStyle];
//}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    return [super pushViewController:viewController animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    self.isPush = NO;
    if ([self.endTransformAnimation isEqualToString:@"1"]) {
        self.delegate = nil;
    }
    return  [super popViewControllerAnimated:animated];
}
- (void)pushViewController:(UIViewController *)viewController animationView:(UIView *)animationView desRec:(CGRect)desRec original:(CGRect)originalRec isPush:(BOOL)isPush {
    self.isPush = isPush;
    self.animationView = animationView;
    self.fromFrame = originalRec;
    self.toFrame = desRec;
    self.delegate = self;
    [self pushViewController:viewController animated:YES];
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    UIView *cell = self.animationView;
    TZLCustomTransformAnimation *animation = [[TZLCustomTransformAnimation alloc] initAnimationWithIsPush:self.isPush animationView:cell fromFrame:self.fromFrame toFrame:self.toFrame];
    return animation;
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.percentDriven;
}

@end
