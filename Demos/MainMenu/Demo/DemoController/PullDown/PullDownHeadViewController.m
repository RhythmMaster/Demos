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
#import "DemoMenuViewController.h"

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
    [self.tableView tzl_addHeadViewWithFrame:CGRectMake(0, 0, kScreenW, 150) view:self.stretchyHeadView];
}
#pragma mark - [self setNeedsStatusBarAppearanceUpdate]给这个方法就能回调到这里
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.barStyleBySelf = YES;
    [self initNavigationViewWithBackgroundColor:[UIColor orangeColor] alpha:0.0 backImageName:@"" backText:@"" title:@""];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset_Y = scrollView.contentOffset.y;
    //150是头部视图的高度 这里取值要固定好 不能通过self.stretchyHeadView.frame.size.height 取
    if (offset_Y >= -statusBarHeight) {
        CGFloat alpha = (statusBarHeight + offset_Y) / (150 - (44 + statusBarHeight));
        [self changeNaviBarAlpha:alpha];
        if (alpha > 0.5) {
            self.statusBarStyle = UIStatusBarStyleLightContent;
        } else {
            self.statusBarStyle = UIStatusBarStyleDefault;
        }
    }
    [self setNeedsStatusBarAppearanceUpdate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoMenuViewController *VC = [DemoMenuViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma  mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        //去掉自带分割线
        //[_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(-20);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 40;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}
- (TZLStretchyHeadView *)stretchyHeadView {
    if (!_stretchyHeadView) {
        _stretchyHeadView = [[TZLStretchyHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 150)];
    }
    return _stretchyHeadView;
}
@end
