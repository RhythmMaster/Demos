//
//  NSString+ToURL.h
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/24.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ToURL)

@property (nonatomic,readonly) NSURL *tzl_URL;

- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString;

@end
