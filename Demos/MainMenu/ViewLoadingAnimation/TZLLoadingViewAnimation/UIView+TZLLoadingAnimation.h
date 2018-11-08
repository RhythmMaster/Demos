//
//  UIView+TZLLoadingAnimation.h
//  Demos
//
//  Created by tang on 2018/11/8.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TZLViewLoadAnimationStyle) {
    TZLViewLoadAnimationDefault = 0,            // default,没有动画,有遮罩层
    TZLViewLoadAnimationNO,                     // 没有动画,没有遮罩层
    TZLViewLoadAnimationStart,                  // 动画开始
    TZLViewLoadAnimationEnd                     // 动画结束
};

typedef NS_ENUM(NSInteger,TZLViewLoadAnimationMode) {
    TZLViewLoadAnimationModeDefault = 0,                // default,没有动画,有遮罩层
    TZLViewLoadAnimationModeToLong,                     // 先变长再变短
    TZLViewLoadAnimationModeToShort,                    // 先变短再变长
};

@interface UIView (TZLLoadingAnimation)
/** 动画style */
@property(nonatomic, assign) TZLViewLoadAnimationStyle animationStyle;
/** 动画长短变化 */
@property(nonatomic, assign) TZLViewLoadAnimationMode animationMode;

/** 当自己作为父视图是利用此属性做一些处理 比如tableView控制多cell动画的开始和结束 */
@property(nonatomic, assign) BOOL startOrEndForSelfIsSuperView;
@end
