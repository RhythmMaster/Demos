//
//  TZLAddVCContextTransitioning.h
//  Demos
//
//  Created by tang on 2018/11/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZLAddVCContextTransitioning : NSObject<UIViewControllerContextTransitioning>
@property (nonatomic, copy) void (^completionBlock)(BOOL didComplete);
- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight;
@end
