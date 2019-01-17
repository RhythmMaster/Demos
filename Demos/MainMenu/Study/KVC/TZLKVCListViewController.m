//
//  TZLKVCListViewController.m
//  Demos
//
//  Created by tang on 2018/11/30.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLKVCListViewController.h"
#import "TZLKVCViewController.h"

@interface TZLKVCListViewController ()

@end

@implementation TZLKVCListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.dataArr = @[[NSString stringWithFormat:@"1. + (BOOL)accessInstanceVariablesDirectly 返回NO实例\n下面就是我们这个属性和实例变量的调用顺序。 \n self.name  \n _name  \n _isName  \n name  \n isName"],
                     @"2. 成员变量_name",
                     @"3. 成员变量_isAge",
                     @"4. 成员变量hegith",
                     @"5. 成员变量isWight",
                     @"6  访问和修改私有变量",
                     [NSString stringWithFormat:@"7  实现多层的消息传递 \n这里说的多层消息传递，主要指的就是对容器类集合元素应用KVC，对集合元素进行操作时，不是对容器本身进行操作，而是对容器中的每个元素进行操作，返回的是结果也是一个集合元素。\n1.[arr valueForKey:@\"capitalizedString\"]方法就是对arr数组的每一个元素进行操作去首字母为大写\n2.[arr valueForKeyPath:@\"capitalizedString.length\"]"],
                     @"8  KVC中的函数对集合进行操作"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        TZLKVCViewController *vc = [TZLKVCViewController new];
        vc.index = indexPath.row;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}



@end
