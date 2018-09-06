//
//  BasicViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/7.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)
                                                 style:(UITableViewStylePlain)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    //去掉自带分割线
    //[_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 40;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method set
- (void)setTableViewFrame:(CGRect)tableViewFrame {
    _tableViewFrame = tableViewFrame;
    self.tableView.frame = tableViewFrame;
    
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 立即取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.controllerArr && self.controllerArr.count > 0) {
        UIViewController *VC = [self.controllerArr[indexPath.row] new];
        VC.title = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (self.didSelectRow) {
        self.didSelectRow(tableView, indexPath);
    }
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArr && self.dataArr.count > 0) {
        return self.dataArr.count;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    if (self.dataArr && self.dataArr.count  > 0) {
        cell.textLabel.text = self.dataArr[indexPath.row];
    } else {
        cell.textLabel.text = @"";
    }
    return cell;
}

@end
