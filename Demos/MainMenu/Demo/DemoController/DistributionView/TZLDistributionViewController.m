//
//  TZLDistributionViewController.m
//  Demos
//
//  Created by tang on 2018/11/12.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLDistributionViewController.h"
#import "TZLSignRecordTVCell.h"

@interface TZLDistributionViewController ()<UITableViewDelegate, UITableViewDataSource>
/**  */
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation TZLDistributionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = tab_kBackColor;
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 80, 200, 40)];
//    [self.view addSubview:view];
//    view.backgroundColor = [UIColor whiteColor];
//
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(44, 100)];
//    [path addLineToPoint:CGPointMake(50, 95)];
//    [path addLineToPoint:CGPointMake(50, 105)];
//    [path addLineToPoint:CGPointMake(44, 100)];
//    layer.path = path.CGPath;
//    layer.fillColor = [UIColor whiteColor].CGColor;
//    [self.view.layer addSublayer:layer];
//
//    path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(6, 6)];
//    layer = [CAShapeLayer layer];
//    layer.path = path.CGPath;
//    layer.fillColor = [UIColor redColor].CGColor;
//    view.layer.mask = layer;
    
    [self tableView];
}

#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 3) {
        TZLSignRecordTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TZLSignRecordTVCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    TZLSignRecordMoreTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TZLSignRecordMoreTVCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma  mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 40;
        _tableView.sectionFooterHeight = 0.1;
        _tableView.sectionHeaderHeight = 0.1;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = tab_kBackColor;
        [_tableView registerClass:[TZLSignRecordTVCell class] forCellReuseIdentifier:@"TZLSignRecordTVCell"];
        [_tableView registerClass:[TZLSignRecordMoreTVCell class] forCellReuseIdentifier:@"TZLSignRecordMoreTVCell"];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }
    return _tableView;
}
@end
