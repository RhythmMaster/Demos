//
//  ViewController.m
//  Demos
//
//  Created by tang on 2018/9/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "ViewController.h"
#import "MKJPresentAnimator.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
/**  */
@property(nonatomic, strong) UIView *animationView;
/**  */
@property(nonatomic, assign) CGRect fromFrame;
/**  */
@property(nonatomic, assign) CGRect toFrame;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated animationView:(UIView *)animationView fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame completion:(void (^)(void))completion {
    viewController.transitioningDelegate = self;
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    self.animationView = animationView;
    self.fromFrame = fromFrame;
    self.toFrame = toFrame;
    [self presentViewController:viewController animated:animated completion:completion];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    UIView *cell = self.animationView;
//    TZLCustomTransformAnimation *animation = [[TZLCustomTransformAnimation alloc] initAnimationWithIsPush:YES animationView:cell fromFrame:self.fromFrame toFrame:self.toFrame];
    MKJPresentAnimator *animation = [MKJPresentAnimator new];
    return animation;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transitioningDelegate = nil;
//    UIView *cell = self.animationView;
//    TZLCustomTransformAnimation *animation = [[TZLCustomTransformAnimation alloc] initAnimationWithIsPush:NO animationView:cell fromFrame:self.fromFrame toFrame:self.toFrame];
    MKJPresentAnimator *animation = [MKJPresentAnimator new];
    return animation;
}
@end
