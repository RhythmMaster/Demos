//
//  UIBarButtonItem+HZBarButtonItem.m
//  BasicProject
//
//  Created by tang on 2018/3/13.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "UIBarButtonItem+HZBarButtonItem.h"

@implementation UIBarButtonItem (HZBarButtonItem)
- (UIBarButtonItem *)createBarItemWithImageName:(NSString *)imageName name:(NSString *)name target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 45, 45);
//    btn.contentEdgeInsets =UIEdgeInsetsMake(0, -15,0, 0);
//    btn.imageEdgeInsets =UIEdgeInsetsMake(0, -10,0, 0);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
