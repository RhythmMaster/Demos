//
//  UIBarButtonItem+HZBarButtonItem.h
//  BasicProject
//
//  Created by tang on 2018/3/13.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HZBarButtonItem)
- (UIBarButtonItem *)createBarItemWithImageName:(NSString *)imageName name:(NSString*)name target:(id)target action:(SEL)action;
@end
