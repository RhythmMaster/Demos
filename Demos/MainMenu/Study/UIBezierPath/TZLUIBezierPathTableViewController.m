//
//  TZLUIBezierPathTableViewController.m
//  Demos
//
//  Created by tang on 2018/9/27.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLUIBezierPathTableViewController.h"
#import "TZLSubUIBezierPathViewController.h"

@interface TZLUIBezierPathTableViewController ()
/**  */
@property(nonatomic, copy) NSArray *dataArr1;
@property(nonatomic, copy) NSArray *dataArr2;
@end

@implementation TZLUIBezierPathTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr1 = @[@"UIBezierPath的创建线条", @"UIBezierPath的创建矩形",
                     @"UIBezierPath的创建圆形", @"UIBezierPath的创建椭圆形",
                     @"drawRect创建文字", @"drawRect创建复杂文字",
                     @"drawRect画图片", @"drawRect下载进度",
                     @"绘制不同颜色的线条的方式1", @"绘制不同颜色的线条的方式2",
                     @"渐变"];
    self.dataArr2 = @[@"UIBezierPath和CAShapeLayer创建圆", @"组合path",
                      @"进度条", @"Slier"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"UITableViewHeaderFooterView"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArr1.count;
    }
    return self.dataArr2.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    if (!headView) {
        headView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
    }
    if (!section) {
        headView.textLabel.text = @"UIBezierPath在view的drawRect:(CGRect)rect中的使用";
    } else {
        headView.textLabel.text = @"UIBezierPath和CAShapeLayer的使用";
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    if (section == 0) {
        cell.textLabel.text = self.dataArr1[row];
    } else {
        cell.textLabel.text = self.dataArr2[row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    TZLSubUIBezierPathViewController *subVC = [TZLSubUIBezierPathViewController new];
    subVC.pathMode = section;
    subVC.pathStyle = row;
    if (section) {
        if (row == 0) {
            subVC.pathStyle = UIBezierPathOfCircleStyle;
        }
        if (row == 1) {
            subVC.pathStyle = UIBezierPathOfOvalStyle;
        }
        if (row == 2) {
            subVC.pathStyle = UIDrawRectOfDownLoadStyle;
        }
        if (row == 3) {
            subVC.pathStyle = UIDrawRectOfSliderStyle;
        }
    }
    [self.navigationController pushViewController:subVC animated:YES];
}

@end
