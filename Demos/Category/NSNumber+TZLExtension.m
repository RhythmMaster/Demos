//
//  NSNumber+TZLExtension.m
//  DemoSet
//
//  Created by tang on 2018/9/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "NSNumber+TZLExtension.h"

@implementation NSNumber (TZLExtension)
- (CGFloat)tzl_CGFloatValue {
#if CGFLOAT_IS_DOUBLE
    return [self doubleValue];
#else
    return [self floatValue];
#endif
}
@end
