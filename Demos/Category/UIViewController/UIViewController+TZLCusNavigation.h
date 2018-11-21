//
//  UIViewController+TZLCusNavigation.h
//  Demos
//
//  Created by tang on 2018/11/20.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TZLCusNavigation)
- (void)initNavigationViewWithBackgroundColor:(UIColor *)backgroundColor alpha:(CGFloat)alpha backImageName:(NSString *)backImageName backText:(NSString *)backText title:(NSString *)title;
//还原系统导航栏
- (void)reBackNavigation;
- (void)changeNaviBarAlpha:(CGFloat)alpha;
@end

typedef void (^TZLCusNavigationViewBackBlock)(UIButton *sender);
@interface TZLCusNavigationView : UIView
/** 返回按钮 */
@property(nonatomic, strong) UIButton *backBtn;
/** title */
@property(nonatomic, strong) UILabel *titleLb;
/**  */
@property(nonatomic, copy) TZLCusNavigationViewBackBlock backBlock;
- (instancetype)initViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor alpha:(CGFloat)alpha backImageName:(NSString *)backImageName backText:(NSString *)backText title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
