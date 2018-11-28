//
//  NSString+ToURL.m
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/24.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import "NSString+ToURL.h"

@implementation NSString (ToURL)

- (NSURL *)tzl_URL{
    return [NSURL URLWithString:self];
}

- (BOOL)isPhoneNumber {
    NSString *phoneNumStr;
    phoneNumStr = [[NSString alloc] initWithString:[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    phoneNumStr = [phoneNumStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *phoneRegex = @"\\b(1)[34578][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b|\\b(1)(7)(7)[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b|\\b(1)(7)(6)[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b";
    NSPredicate *phoneCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    if (![phoneCheck evaluateWithObject:phoneNumStr]) {
        
        return NO;
    }
    
    return YES;
}

- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString {
    if (IsEmptyStr(fromString) || IsEmptyStr(toString)) {
        return nil;
    }
    NSMutableArray *subStringsArray = [[NSMutableArray alloc] init];
    NSString *tempString = self;
    NSRange range = [tempString rangeOfString:fromString];
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            [subStringsArray addObject:[tempString substringToIndex:range.location]];
            range = [tempString rangeOfString:fromString];
        }
        else
        {
            break;
        }
    }
    return subStringsArray;
}

@end
