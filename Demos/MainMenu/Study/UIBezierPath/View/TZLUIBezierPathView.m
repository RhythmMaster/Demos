//
//  TZLUIBezierPathView.m
//  Demos
//
//  Created by tang on 2018/9/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLUIBezierPathView.h"

@interface TZLUIBezierPathView()
/**  */
@property(nonatomic, assign) UIBezierPathAndDrawRectStyle pathStyle;
/**  */
@property(nonatomic, strong) UILabel *progressLb;
@end

@implementation TZLUIBezierPathView

- (instancetype)initWithFrame:(CGRect)frame pathStyle:(UIBezierPathAndDrawRectStyle)pathStyle {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.pathStyle = pathStyle;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    //会调用drawRect:(CGRect)rect
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (self.pathStyle == UIBezierPathOfLineStyle) {
        //不用上下文也可以
        [self UIBezierPathOfLineStyle];
        
    } else if (self.pathStyle == UIBezierPathOfRectangleStyle) {
        //利用上下文
        [self UIBezierPathOfRectangleStyleWithContext:ctx];
        
    }  else if (self.pathStyle == UIBezierPathOfCircleStyle) {
        [self UIBezierPathOfCircleStyleWithContext:ctx];
        
    }  else if (self.pathStyle == UIBezierPathOfOvalStyle) {
        [self UIBezierPathOfOvalStyle];
        
    } else if (self.pathStyle == UIDrawRectOfTextStyle) {
        [self UIDrawRectOfTextStyleWithContext:ctx];
        
    } else if (self.pathStyle == UIDrawRectOfComplexTextStyle) {
        [self UIDrawRectOfComplexTextStyleWithContext:ctx];
        
    } else if (self.pathStyle == UIDrawRectOfImageStyle) {
        [self UIDrawRectOfImageStyleWithContext:ctx];
        
    } else if (self.pathStyle == UIDrawRectOfDownLoadStyle) {
        [self UIDrawRectOfDownLoadStyle];
        
    } else if (self.pathStyle == UIDrawRectOfMultipleColorStyle1) {
        [self UIDrawRectOfMultipleColorStyle1WithContext:ctx];
        
    } else if (self.pathStyle == UIDrawRectOfMultipleColorStyle2) {
        [self UIDrawRectOfMultipleColorStyle2];
        
    } else if (self.pathStyle == UIDrawRectOfGradientStyle) {
        [self UIDrawRectOfGradientStyleWithContext:ctx];
    }
}
- (void)UIBezierPathOfLineStyle {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(200, 300)];
    [path addLineToPoint:CGPointMake(100, 200)];
    path.lineWidth = 5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [[UIColor blueColor] setStroke];
    [path stroke];
}
- (void)UIBezierPathOfRectangleStyleWithContext:(CGContextRef)ctx {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(70, 70, 100, 100)];
    path.lineWidth = 5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [[UIColor orangeColor] setStroke];
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}
- (void)UIBezierPathOfCircleStyleWithContext:(CGContextRef)ctx {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:80 startAngle:0 endAngle:M_PI * 2  clockwise:YES];
    path.lineWidth = 2;
    [[UIColor greenColor] setStroke];
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}
- (void)UIBezierPathOfOvalStyle {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 150)];
    path.lineWidth = 5;
    [[UIColor redColor] setStroke];
    [[UIColor cyanColor] setFill];
    [path stroke];
    [path fill];
}
- (void)UIDrawRectOfTextStyleWithContext:(CGContextRef)ctx {
    NSString *text = @"这真的行吗";
    //设置字体样式
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    //字体背景色
    dict[NSBackgroundColorAttributeName] = [UIColor redColor];
    //大小没用 只能是坐标有用
    [text drawInRect:CGRectMake(100, 70, 200, 80) withAttributes:dict];
    CGContextStrokePath(ctx);
}
- (void)UIDrawRectOfComplexTextStyleWithContext:(CGContextRef)ctx {
    NSString *text = @"这真的行吗";
    //设置字体样式
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    //NSFontAttributeName:字体大小
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:25];
    //字体前景色
    dict[NSForegroundColorAttributeName] = [UIColor blueColor];
    //字体背景色
    dict[NSBackgroundColorAttributeName] = [UIColor redColor];
    //字体阴影
    NSShadow * shadow = [[NSShadow alloc]init];
    //阴影偏移量
    shadow.shadowOffset = CGSizeMake(2, 2);
    //阴影颜色
    shadow.shadowColor = [UIColor greenColor];
    //高斯模糊
    shadow.shadowBlurRadius = 5;
    dict[NSShadowAttributeName] = shadow;
    //字体间距
    dict[NSKernAttributeName] = @10;
    [text drawAtPoint:CGPointMake(100, 70) withAttributes:dict];
    CGContextStrokePath(ctx);
}
- (void)UIDrawRectOfImageStyleWithContext:(CGContextRef)ctx {
    UIImage *image = [UIImage imageNamed:@"hanbing"];
    //大小坐标都有用
    [image drawInRect:CGRectMake(100, 70, 280, 300) blendMode:kCGBlendModeNormal alpha:0.6];
    CGContextFillPath(ctx);
}
- (void)UIDrawRectOfDownLoadStyle {
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 + self.progress * M_PI * 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5) radius:self.bounds.size.width * 0.2 startAngle:startA endAngle:endA clockwise:YES];
    path.lineWidth = 5;
    [[UIColor colorWithRed:self.progress green:(1- self.progress) blue:0 alpha:1] setStroke];
    [path stroke];
    
    if (!self.progressLb) {
        UILabel *progressLb = [UILabel new];
        self.progressLb = progressLb;
        [self addSubview:progressLb];
        progressLb.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        progressLb.font = [UIFont systemFontOfSize:13];
        progressLb.textAlignment = NSTextAlignmentCenter;
    }
    self.progressLb.textColor = [UIColor colorWithRed:self.progress green:(1- self.progress) blue:0 alpha:1];
    self.progressLb.text = [NSString stringWithFormat:@"%.1f%%", self.progress * 100];
    [self.progressLb sizeToFit];
}
- (void)UIDrawRectOfMultipleColorStyle1WithContext:(CGContextRef)ctx {
    //1 获取上下文
    //分别设置线段的颜色
    CGContextRef purple = UIGraphicsGetCurrentContext();
    [[UIColor purpleColor] setStroke];
    CGContextSaveGState(purple);
    
    CGContextRef orange = UIGraphicsGetCurrentContext();
    [[UIColor orangeColor] setStroke];
    CGContextSaveGState(orange);
    
    CGContextRef green = UIGraphicsGetCurrentContext();
    [[UIColor greenColor] setStroke];
    CGContextSaveGState(green);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5;
    CGContextRestoreGState(purple);
    [[UIColor purpleColor] setStroke];
    [path moveToPoint:CGPointMake(10, 70)];
    [path addLineToPoint:CGPointMake(10, 170)];
    [path stroke];
    
    path = [UIBezierPath bezierPath];
    path.lineWidth = 7;
    CGContextRestoreGState(orange);
    [[UIColor orangeColor] setStroke];
    [path moveToPoint:CGPointMake(50, 70)];
    [path addLineToPoint:CGPointMake(50, 170)];
    [path stroke];
    
    path = [UIBezierPath bezierPath];
    path.lineWidth = 9;
    CGContextRestoreGState(green);
    [[UIColor greenColor] setStroke];
    [path moveToPoint:CGPointMake(90, 70)];
    [path addLineToPoint:CGPointMake(90, 170)];
    [path stroke];
}
- (void)UIDrawRectOfMultipleColorStyle2 {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5;
    [[UIColor redColor] setStroke];
    [path moveToPoint:CGPointMake(20, 70)];
    [path addLineToPoint:CGPointMake(20, 170)];
    [path stroke];
    
    path = [UIBezierPath bezierPath];
    path.lineWidth = 7;
    [[UIColor blueColor] setStroke];
    [path moveToPoint:CGPointMake(50, 70)];
    [path addLineToPoint:CGPointMake(50, 170)];
    [path stroke];
    
    path = [UIBezierPath bezierPath];
    path.lineWidth = 9;
    [[UIColor cyanColor] setStroke];
    [path moveToPoint:CGPointMake(70, 70)];
    [path addLineToPoint:CGPointMake(70, 170)];
    [path stroke];
}
- (void)UIDrawRectOfGradientStyleWithContext:(CGContextRef)ctx {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5;
    [path moveToPoint:CGPointMake(30, 80)];
    [path addLineToPoint:CGPointMake(230, 80)];
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
    //3、创建一个颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //4、设置颜色的location
    CGFloat locations[] = { 0.0, 1.0 };
    //5、创建一个颜色数组，由于NSArray里面只能存对象，所以需要桥接
    NSArray *colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor greenColor].CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    //释放
    CFRelease(colorSpace);
    //保存一份当前上下文，压栈
    CGContextSaveGState(ctx);
    
    //裁剪
    CGContextEOClip(ctx);
    
    //绘制渐变
    CGContextDrawLinearGradient(ctx, gradient, CGPointMake(0, 100), CGPointMake(self.frame.size.width, 100), kCGGradientDrawsBeforeStartLocation);
    
    //恢复一份当前的上下文，出栈
    CGContextRestoreGState(ctx);
    
    //释放内存
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}
@end
