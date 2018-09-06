//
//  BasicViewController.h
//  DemoSet
//
//  Created by tang on 2017/12/7.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^didSelectRow) (UITableView *tableView, NSIndexPath *indexPath);
@interface BasicViewController : UIViewController
@property(nonatomic, copy) NSArray *dataArr;
@property(nonatomic, copy) NSArray *controllerArr;
/** 更新tableView.frame */
@property(nonatomic, assign) CGRect tableViewFrame;

/** 处理一些自定义的点击事件 */
@property(nonatomic, copy) didSelectRow didSelectRow;
@end
