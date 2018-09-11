//
//  PullDownHeadViewController.m
//  Demos
//
//  Created by tang on 2018/9/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "PullDownHeadViewController.h"
#import <objc/runtime.h>

#import "TZLStretchyHeadView.h"

@interface PullDownHeadViewController ()<UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
/** 可伸展的头部 */
@property(nonatomic, strong) TZLStretchyHeadView *stretchyHeadView;
/** 控制当前状态栏 */
@property (nonatomic,assign) UIStatusBarStyle statusBarStyle;
@end

@implementation PullDownHeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
#pragma mark - [self setNeedsStatusBarAppearanceUpdate]给这个方法就能回调到这里
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.tzl_navigationBarBackgroundAlpha = 0.f;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tzl_navigationBarBackgroundAlpha = 0.f;
    [self tableView];
    self.stretchyHeadView = [[TZLStretchyHeadView alloc] initWithFrame:CGRectMake(0, -164, self.view.width, 164)];
    [self.tableView addSubview:self.stretchyHeadView];
    self.statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset_Y = scrollView.contentOffset.y;
    //NSLog(@"%f", offset_Y);
    if (offset_Y < -64) {
        self.statusBarStyle = UIStatusBarStyleLightContent;
    } else {
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    [self setNeedsStatusBarAppearanceUpdate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

#pragma  mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height) style:(UITableViewStylePlain)];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        //去掉自带分割线
        //[_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 40;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

@end
