//
//  UINavigationController+TZLStatusBarStyle.h
//  Demos
//
//  Created by tang on 2018/9/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (TZLStatusBarStyle)

@end
@interface UIViewController (TZLStatusBarStyle)
/** 是否自己控制barStyle,而不依赖navi,默认为NO,也就是根据导航栏设置
 当设置为YES时,[self setNeedsStatusBarAppearanceUpdate]来显视调用preferredStatusBarStyle这个方法才能更改StatusBar的颜色
 */
@property(nonatomic, assign) BOOL barStyleBySelf;
@end
