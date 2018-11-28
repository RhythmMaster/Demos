//
//  UIImage+TZLCircleImage.m
//  CircleImage
//
//  Created by tang on 2018/11/27.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "UIImage+TZLCircleImage.h"

@implementation UIImage (TZLCircleImage)
- (UIImage *)circleImage {
    
    //开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    //根据范围创建椭圆
    CGContextAddEllipseInRect(ctx, rect);
    
    //裁剪
    CGContextClip(ctx);
    
    //将原照片画到图形上下文
    [self drawInRect:rect];
    
    // 从上下文上获取剪裁后的照片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return circleImage;
}
@end
