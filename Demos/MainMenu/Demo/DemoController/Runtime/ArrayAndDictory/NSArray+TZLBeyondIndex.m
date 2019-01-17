//
//  NSArray+TZLBeyondIndex.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "NSArray+TZLBeyondIndex.h"
//#import "NSObject+HZRuntime.h"

@implementation NSArray (TZLBeyondIndex)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSArray0Class = objc_getClass("__NSArray0");
        Class NSSingleObjectArrayIClass = objc_getClass("__NSSingleObjectArrayI");
        Class NSArrayIClass = objc_getClass("__NSArrayI");
        
        SEL oriSEL = @selector(objectAtIndex:);
//        SEL sbscriptOriSEL = @selector(objectAtIndexedSubscript:);
        
        SEL NSArray0SEL = @selector(tzl_NSArray0BeyondIndexObjectAtIndex:);
        SEL NSSingleObjectArrayISEL = @selector(tzl_NSSingleObjectArrayIBeyondIndexObjectAtIndex:);
        SEL NSArrayISEL = @selector(tzl_NSArrayIBeyondIndexObjectAtIndex:);
        
        [NSArray0Class swizzleInstanceMethod:oriSEL with:NSArray0SEL];
        [NSSingleObjectArrayIClass swizzleInstanceMethod:oriSEL with:NSSingleObjectArrayISEL];
        [NSArrayIClass swizzleInstanceMethod:oriSEL with:NSArrayISEL];
//        [NSArrayIClass swizzleInstanceMethod:sbscriptOriSEL with:NSArrayISEL];
        
    });
}
- (id)tzl_NSArray0BeyondIndexObjectAtIndex:(NSInteger)index {
    if (index < self.count) {//没问题的
        return [self tzl_NSArray0BeyondIndexObjectAtIndex:index];
    } else {//越界
        @try {
            return [self tzl_NSArray0BeyondIndexObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"------------__NSArray0数组越界了!,下标%ld超过了数组最大下标%ld------------", index, self.count - 1);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally {
            NSLog(@"nothing to do");
        }
    }
}
- (id)tzl_NSArrayIBeyondIndexObjectAtIndex:(NSInteger)index {
    if (index < self.count) {//没问题的
        return [self tzl_NSArrayIBeyondIndexObjectAtIndex:index];
    } else {//越界
        @try {
            return [self tzl_NSArrayIBeyondIndexObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"------------__NSArrayI数组越界了!,下标%ld超过了数组最大下标%ld------------", index, self.count - 1);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally {
            NSLog(@"nothing to do");
        }
    }
}
- (id)tzl_NSSingleObjectArrayIBeyondIndexObjectAtIndex:(NSInteger)index {
    if (index < self.count) {//没问题的
        return [self tzl_NSSingleObjectArrayIBeyondIndexObjectAtIndex:index];
    } else {//越界
        @try {
            return [self tzl_NSSingleObjectArrayIBeyondIndexObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"------------__NSSingleObjectArrayI数组越界了!,下标%ld超过了数组最大下标%ld------------", index, self.count - 1);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally {
            NSLog(@"nothing to do");
        }
    }
}
@end
