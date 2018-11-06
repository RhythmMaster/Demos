//
//  TZLAddVCOneViewController.m
//  Demos
//
//  Created by tang on 2018/10/24.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLAddVCOneViewController.h"
#import "TZLAddVCAnimatedTransitioning.h"
#import "TZLAddVCContextTransitioning.h"

static CGFloat const kButtonSlotWidth = 64; // Also distance between button centers
//static CGFloat const kButtonSlotHeight = 44;

@interface TZLAddVCOneViewController ()
/** 子控制器 */
@property(nonatomic, strong) NSArray<UIViewController *> *viewControllers;
/**  */
@property(nonatomic, strong) UIView *childView;
/**  */
@property(nonatomic, strong) UIView *changeBtnView;
@end

@implementation TZLAddVCOneViewController

- (instancetype)init {
    if (self = [super init]) {
        if (!self.viewControllers) {
            NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:3];
            for (NSInteger i = 0; i < 3; i++) {
                TZLChildViewController *childVC = [[TZLChildViewController alloc] init];
                switch (i) {
                    case 0:
                        childVC.backgroundColor = [UIColor colorWithRed:0.4f green:0.8f blue:1 alpha:1];
                        childVC.textTitle = @"First";
                        break;
                    case 1:
                        childVC.backgroundColor = [UIColor colorWithRed:1 green:0.4f blue:0.8f alpha:1];
                        childVC.textTitle = @"Second";
                        break;
                    case 2:
                        childVC.backgroundColor = [UIColor colorWithRed:1 green:0.8f blue:0.4f alpha:1];
                        childVC.textTitle = @"Third";
                        break;
                    default:
                        break;
                }
                [tmpArr addObject:childVC];
            }
            self.viewControllers = tmpArr.copy;
        }
    }
    return self;
}

- (instancetype)initWithChildViewControllers:(NSArray<UIViewController *> *)childViewControllers {
    if (self = [super init]) {
        
        if (!childViewControllers) {
            NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:3];
            for (NSInteger i = 0; i < 3; i++) {
                TZLChildViewController *childVC = [[TZLChildViewController alloc] init];
                switch (i) {
                    case 0:
                        childVC.backgroundColor = [UIColor colorWithRed:0.4f green:0.8f blue:1 alpha:1];
                        childVC.textTitle = @"First";
                        break;
                    case 1:
                        childVC.backgroundColor = [UIColor colorWithRed:1 green:0.4f blue:0.8f alpha:1];
                        childVC.textTitle = @"Second";
                        break;
                    case 2:
                        childVC.backgroundColor = [UIColor colorWithRed:1 green:0.8f blue:0.4f alpha:1];
                        childVC.textTitle = @"Third";
                        break;
                    default:
                        break;
                }
                [tmpArr addObject:childVC];
            }
            childViewControllers = tmpArr.copy;
        }
        self.viewControllers = childViewControllers;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *childView = [[UIView alloc] init];
    childView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:childView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:childView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    childView.backgroundColor = [UIColor redColor];
    self.childView = childView;
    
    UIView *changeBtnView = [[UIView alloc] init];
    changeBtnView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:changeBtnView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:changeBtnView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:changeBtnView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.4 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:changeBtnView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:[self.viewControllers count] * kButtonSlotWidth]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:changeBtnView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kButtonSlotWidth]];
    changeBtnView.backgroundColor = [UIColor cyanColor];
    self.changeBtnView = changeBtnView;
    
    [self addChangeBtn];
    
    self.selectedViewController = self.selectedViewController ?: self.viewControllers[0];
}

- (void)addChangeBtn {
    NSArray *tmp = @[@"First", @"Second", @"Third"];
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull childViewController, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *icon = [[UIImage imageNamed:tmp[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [button setImage:icon forState:UIControlStateNormal];
        UIImage *selectedIcon = [[UIImage imageNamed:[NSString stringWithFormat:@"%@ Selected", tmp[idx]]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [button setImage:selectedIcon forState:UIControlStateSelected];
        
        button.tag = idx;
        [button addTarget:self action:@selector(_buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.changeBtnView addSubview:button];
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.changeBtnView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.changeBtnView attribute:NSLayoutAttributeLeading multiplier:1 constant:(idx + 0.5f) * kButtonSlotWidth]];
        [self.changeBtnView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.changeBtnView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    }];
}

- (void)_buttonTapped:(UIButton *)sender {
    self.selectedViewController = self.viewControllers[sender.tag];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    _selectedViewController = selectedViewController;
    [self transtionToChildViewController:selectedViewController];
    [self updateSelectedBtn];
}
- (void)updateSelectedBtn {
    [self.changeBtnView.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        button.selected = (self.selectedViewController == self.viewControllers[idx]);
    }];
}
- (void)transtionToChildViewController:(UIViewController *)toViewController {
    UIViewController *fromViewController = self.childViewControllers.count ? self.childViewControllers.firstObject: nil;
    if (fromViewController == toViewController) {
        return;
    }
    UIView *toView = toViewController.view;
    toView.translatesAutoresizingMaskIntoConstraints = YES;
    toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toView.frame = self.childView.bounds;
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    [self.childView addSubview:toView];
    if (!self.haveAnimate) {//没有动画的
        [fromViewController.view removeFromSuperview];
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
    } else {//有动画的
        if (!fromViewController) {//第一次的不做动画
            [fromViewController.view removeFromSuperview];
            [fromViewController removeFromParentViewController];
            [toViewController didMoveToParentViewController:self];
            return;
        }
        
        NSUInteger fromIndex = [self.viewControllers indexOfObject:fromViewController];
        NSUInteger toIndex = [self.viewControllers indexOfObject:toViewController];
        TZLAddVCAnimatedTransitioning *animation = [[TZLAddVCAnimatedTransitioning alloc] init];
        TZLAddVCContextTransitioning *context = [[TZLAddVCContextTransitioning alloc] initWithFromViewController:fromViewController toViewController:toViewController goingRight:(toIndex > fromIndex)];
        context.completionBlock = ^(BOOL didComplete) {
            [fromViewController.view removeFromSuperview];
            [fromViewController removeFromParentViewController];
            [toViewController didMoveToParentViewController:self];
            self.changeBtnView.userInteractionEnabled = YES;
        };
        self.changeBtnView.userInteractionEnabled = NO;
        [animation animateTransition:context];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
