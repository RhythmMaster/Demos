//
//  TZLRuntimeListViewController.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLRuntimeListViewController.h"
#import "TZLRuntimeViewController.h"
#import "TZLSubRuntimeViewController.h"

@interface TZLRuntimeListViewController ()

@end

@implementation TZLRuntimeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"1.只有方法实现,没有方法声明,class_getInstanceMethod()函数能否取到,只声明不实现就会崩溃/n结论: 只要方法实现了,都能class_getInstanceMethod()取到",
                     @"2.父类有实现,但是没声明class_getInstanceMethod()函数能否取到/n结论: 父类",
                     @"3.父类有实现,有声明class_getInstanceMethod()函数能否取到/n结论: 父类",
                     @"4.class_addMethod,如果被替换的方法已经实现,则替换失败,并且返回NO",
                     @"5.class_addMethod,如果被替换的方法未实现,则替换成功,并且返回YES",
                     @"6.class_replaceMethod",
                     @"7.+ (void)load",
                     @"8.+ (void)load 子类未实现,父类有实现",
                     @"9.+ (void)load 为子类写的分类 子类实现,父类实现",
                     @"9.+ class_replaceMethod 为子类写的分类 子类未实现,父类实现"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9) {
            TZLRuntimeViewController *vc = [TZLRuntimeViewController new];
            vc.index = indexPath.row;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1 || indexPath.row == 2) {
            TZLSubRuntimeViewController *vc = [TZLSubRuntimeViewController new];
            vc.index = indexPath.row;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
    };
}



@end
