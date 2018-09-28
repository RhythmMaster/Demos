//
//  TZLSubUIBezierPathViewController.h
//  Demos
//
//  Created by tang on 2018/9/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "ViewController.h"
#import "TZLUIBezierPathView.h"

typedef enum : NSUInteger {
    UIBezierPathWithDrawRectMode,
    UIBezierPathWithLayerMode
} UIBezierPathMode;



@interface TZLSubUIBezierPathViewController : ViewController
/**  */
@property(nonatomic, assign) UIBezierPathMode pathMode;
/**  */
@property(nonatomic, assign) UIBezierPathAndDrawRectStyle pathStyle;
@end
