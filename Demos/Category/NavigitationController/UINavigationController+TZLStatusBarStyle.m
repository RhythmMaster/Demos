//
//  UINavigationController+TZLStatusBarStyle.m
//  Demos
//
//  Created by tang on 2018/9/6.
//  Copyright © 2018年 TZL. All rights reserved.
//
/**
 分析下
 
 - (UIStatusBarStyle)preferredStatusBarStyle
 
 在需要的控制器里面重写这个方法，返回值就是UIStatusBarStyleDefault或者UIStatusBarStyleLightContent
 
 在该方法里面，如果只是简单的返回值而已，那么该界面在显示的时候会立马改变StatusBar的前景部分
 
 如果该VC已经显示出来了，你需要做的就是根据滚动的偏移量在实时更改StatusBar的前景颜色，那么你就要用到
 
 [self setNeedsStatusBarAppearanceUpdate]来显视调用preferredStatusBarStyle这个方法才能更改StatusBar
 
 的颜色
 
 
 
 然而这个时候坑来了，你以为这样设置好就完了么，他就会调用了么，你真的是too young too naive
 
 最关键的东西来了
 
 - (UIViewController *)childViewControllerForStatusBarStyle:
 为什么要重写这个东西呢
 
 这个方法默认返回值是nil。也就是当我们调用setNeedsStatusBarAppearanceUpdate的时候，系统会调用container（容器控制器）的preferredStatusBarStyle这个方法（app.window.rootViewController的preferred的方法，一般我们用UINavigationController或者UITabBarController来做container），也就是根本不会调用子控制器（我们所看到的UIViewcontroller）的preferredStatusBarStyle方法。这个时候- (UIViewController *)childViewControllerForStatusBarStyle:就派上用场了
 
 该类扩展的意思就是，我重写了，你不要调用Container（NavigationController或者UITabBarController）的preferredStatusBarStyle这个方法了，去调用self.visibleViewController的preferredStatusBarStyle，那么，我们写在UIViewcontroller里面的方法就会被调用了，就能更改StatusBar的前景颜色了
 
 
 
 总结：
 
 只要UIViewController重写的childViewControllerForStatusBarStyle返回值不是nil，那么UIViewcontroller的preferredStatusBarStyle方法不会被系统的Container（NavigationController或者UITabBarController）调用，而是调用childViewControllerForStatusBarStyle返回的UIViewController的preferredStatusBarStyle来控制StatuBar的颜色
 */

#import "UINavigationController+TZLStatusBarStyle.h"

@implementation UINavigationController (TZLStatusBarStyle)
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.visibleViewController;
}
@end
