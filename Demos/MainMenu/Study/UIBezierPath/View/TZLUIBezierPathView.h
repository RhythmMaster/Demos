//
//  TZLUIBezierPathView.h
//  Demos
//
//  Created by tang on 2018/9/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UIBezierPathOfLineStyle,
    UIBezierPathOfRectangleStyle,
    UIBezierPathOfCircleStyle,
    UIBezierPathOfOvalStyle,
    UIDrawRectOfTextStyle,
    UIDrawRectOfComplexTextStyle,
    UIDrawRectOfImageStyle,
    UIDrawRectOfDownLoadStyle,
    UIDrawRectOfMultipleColorStyle1,
    UIDrawRectOfMultipleColorStyle2,
    UIDrawRectOfGradientStyle,
    UIDrawRectOfSliderStyle,
} UIBezierPathAndDrawRectStyle;

@interface TZLUIBezierPathView : UIView
- (instancetype)initWithFrame:(CGRect)frame pathStyle:(UIBezierPathAndDrawRectStyle)pathStyle;

/** 下载进度 */
@property(nonatomic, assign) CGFloat progress;
@end
