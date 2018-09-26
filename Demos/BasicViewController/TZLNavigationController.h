//
//  TZLNavigationController.h
//  DemoSet
//
//  Created by tang on 2018/6/7.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZLNavigationController : UINavigationController
/**
 viewController: push的VC
 imageView: 做动画的view
 desRec: 终点frame
 originalRec: 起点frame
 isPush: 是否push pop
 */
- (void)pushViewController:(UIViewController *)viewController animationView:(UIView *)animationView desRec:(CGRect)desRec original:(CGRect)originalRec isPush:(BOOL)isPush;
@end
