//
//  UITextField+TZLExtension.h
//  Demos
//
//  Created by tang on 2018/11/28.
//  Copyright © 2018年 TZL. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (TZLExtension)
/** placeholder颜色 */
@property(nonatomic, strong) UIColor *placeholderColor;
/** placeholder字体大小 */
@property(nonatomic, strong) UIFont *placeholderFont;
/** placeholder距离左边距,暂时没想到好办法,只能固定了两个空格的u距离 */
@property(nonatomic, assign) CGFloat marginLeftOfPlaceholder;
/** 边框颜色 */
@property(nonatomic, strong) UIColor *borderColor;
@end

NS_ASSUME_NONNULL_END
