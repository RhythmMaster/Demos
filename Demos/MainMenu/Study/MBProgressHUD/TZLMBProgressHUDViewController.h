//
//  TZLMBProgressHUDViewController.h
//  Demos
//
//  Created by tang on 2018/11/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZLMBProgressHUDViewController : UIViewController
/**
 @"1. 默认模式,使用系统自带的指示器 ,不能显示进度,只能不停地转呀转 MBProgressHUDModeIndeterminate",
 @"2. 用饼状图显示进度 MBProgressHUDModeDeterminate",
 @"3. 进度条 MBProgressHUDModeDeterminateHorizontalBar",
 @"4. 圆环 MBProgressHUDModeAnnularDeterminate",
 @"5. 自定义视图 MBProgressHUDModeCustomView",
 @"6. 只显示文字 MBProgressHUDModeText"
 */
@property(nonatomic, assign) NSInteger index;
@end

NS_ASSUME_NONNULL_END
