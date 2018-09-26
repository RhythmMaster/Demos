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
@end

@implementation TZLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.navigationBar navBarToBeSystem];
    self.isPush = NO;
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
    if (!self.isPush) {
        self.delegate = nil;
    }
    return animation;
}
@end
