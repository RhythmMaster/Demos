//
//  TZLLoadingViewAnimation.h
//  Demos
//
//  Created by tang on 2018/11/8.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+TZLLoadingAnimation.h"

@interface TZLLoadingViewAnimation : NSObject

@property (nonatomic, assign) CGFloat animatedDuration;             // default is 0.4. the duartion of your animations.
@property (nonatomic, strong) UIColor *animatedColor;       // default is 0xEEEEEE. the backgroundcolor of your animations.
@property (nonatomic, assign) CGFloat longToValue;                  // default is 1.5. toValue for LongAnimation
@property (nonatomic, assign) CGFloat shortToValue;                 // default is 0.5. toValue for ShortAnimation

+ (instancetype)shareLoadData;

/** 按照子视图的状态判定动画 */
- (void)startOrEndViewAnimated:(UIView *)view;
/** 按照子视图的状态判定动画多view时候 */
- (void)startOrEndViewAnimatedWithViews:(NSArray<UIView *> *)views;

/** 所有子视图的开始动画 */
- (void)startSubViewAnimated:(UIView *)view;
/** 所有子视图的开始动画多view时候 */
- (void)startSubViewAnimatedWithViews:(NSArray<UIView *> *)views;
/** 所有子视图的停止动画 */
- (void)endSubViewAnimated:(UIView *)view;
/** 所有子视图的停止动画多view时候 */
- (void)endSubViewAnimatedWithViews:(NSArray<UIView *> *)views;


@end
