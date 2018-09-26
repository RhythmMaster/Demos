//
//  ViewController.h
//  Demos
//
//  Created by tang on 2018/9/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated animationView:(UIView *)animationView fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame completion:(void (^ __nullable)(void))completion;

@end

