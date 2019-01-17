//
//  UITextField+TZLExtension.m
//  Demos
//
//  Created by tang on 2018/11/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "UITextField+TZLExtension.h"
#import <objc/runtime.h>

@implementation UITextField (TZLExtension)
- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    if (self.placeholderFont != placeholderFont) {
        [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
    }
    objc_setAssociatedObject(self, @selector(placeholderFont), placeholderFont, OBJC_ASSOCIATION_RETAIN);
}
- (UIFont *)placeholderFont {
    return objc_getAssociatedObject(self, @selector(placeholderFont));
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    if (self.placeholderColor != placeholderColor) {
        [self setValue:[UIColor blueColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    objc_setAssociatedObject(self, @selector(placeholderColor), placeholderColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIFont *)placeholderColor {
    return objc_getAssociatedObject(self, @selector(placeholderColor));
}
- (void)setMarginLeftOfPlaceholder:(CGFloat)marginLeftOfPlaceholder {
    objc_setAssociatedObject(self, @selector(marginLeftOfPlaceholder), @(marginLeftOfPlaceholder), OBJC_ASSOCIATION_RETAIN);
    NSString *placehoder = self.placeholder;
    self.placeholder = [NSString stringWithFormat:@"  %@", placehoder ?: @""];
}
- (CGFloat)marginLeftOfPlaceholder {
    return [objc_getAssociatedObject(self, @selector(marginLeftOfPlaceholder)) floatValue];
}
- (void)setBorderColor:(UIColor *)borderColor {
    if (self.borderColor != borderColor) {
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = 0.9;
    }
    objc_setAssociatedObject(self, @selector(borderColor), borderColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, @selector(borderColor));
}
@end
