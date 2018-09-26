//
//  TZLCustomTransformAnimation.h
//  Demos
//
//  Created by tang on 2018/9/26.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZLCustomTransformAnimation : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype)initAnimationWithIsPush:(BOOL)isPush animationView:(UIView *)animationView fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame;
@end
