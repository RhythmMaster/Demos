//
//  Constants.h
//  Demos
//
//  Created by tang on 2018/9/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#ifdef DEBUG
#define PPLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define PPLog(...)
#endif


//三原色的设置
#define kRGBA(R,G,B,A) ([UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:A])
#define RadomColor [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1]
#define tab_kColor(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]
#define tab_kBackColor tab_kColor(0xEEEEEEFF)
#define kTVBackColor kRGBA(235,235,241,1.0)

#define WK(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//屏幕宽度 高度
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)

#define statusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)

//当前系统版本
#define tCurrentDeviceVersion ([UIDevice currentDevice].systemVersion.floatValue)

#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE4           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)
#define UI_IS_IPHONE5           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define UI_IS_IPHONE6           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define UI_IS_IPHONE6PLUS       (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0) // Both orientations

/**
 *  判断是否是空字符串 非空字符串 ＝ yes
 *
 *  @param string
 *
 *  @return
 */

#define  NOEmptyStr(string)  string == nil || string == NULL ||[string isKindOfClass:[NSNull class]] || [string isEqualToString: @""]  ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? NO : YES

/**
 *  判断是否是空字符串 空字符串 = yes
 *
 *  @param string
 *
 *  @return
 */
#define  IsEmptyStr(string) string == nil || string == NULL ||[string isKindOfClass:[NSNull class]]|| [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? YES : NO


#endif /* Constants_h */
