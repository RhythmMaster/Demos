//
//  TZLViewLoadingAnimationViewController.m
//  Demos
//
//  Created by tang on 2018/11/7.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLViewLoadingAnimationViewController.h"
#import "TZLLoadingViewAnimation.h"
#import "TZLLoadingTableViewCell.h"

@interface CustomView: UIView
/**  */
@property(nonatomic, strong) UIImageView *imageView;
/**  */
@property(nonatomic, strong) UILabel *titleLb;
/**  */
@property(nonatomic, strong) UILabel *textLb;
@end

@interface TZLViewLoadingAnimationViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *dataArray;
}
/**  */
@property(nonatomic, strong) CustomView *customView;
@property(nonatomic, strong) CustomView *customView1;
@property(nonatomic, strong) CustomView *customView2;

@property (nonatomic, strong) UITableView *mainTV;
@end

@implementation TZLViewLoadingAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomView *customView = [[CustomView alloc] init];
    [self.view addSubview:customView];
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(70);
        make.top.equalTo(64);
    }];
    self.customView = customView;
    
    CustomView *customView1 = [[CustomView alloc] init];
    [self.view addSubview:customView1];
    [customView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(70);
        make.top.equalTo(customView.mas_bottom).equalTo(20);
    }];
//    customView1.backgroundColor = [UIColor redColor];
    self.customView1 = customView1;
    
    CustomView *customView2 = [[CustomView alloc] init];
    [self.view addSubview:customView2];
    [customView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(70);
        make.top.equalTo(customView1.mas_bottom).equalTo(20);
    }];
//    customView2.backgroundColor = [UIColor orangeColor];
    self.customView2 = customView2;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[TZLLoadingViewAnimation shareLoadData] startSubViewAnimatedWithViews:@[customView, customView1, customView2]];
        [self performSelector:@selector(endViewAnimated:) withObject:customView afterDelay:3.5];
    });
    
    [self initData];
    [self initUI];
}

/**
 load data
 加载数据
 */
- (void)initData {
    
    dataArray = [NSMutableArray arrayWithCapacity:5];
}
/**
 initize view
 视图初始化
 */
- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mainTV];
    [[TZLLoadingViewAnimation shareLoadData] startSubViewAnimated:self.mainTV];
}

- (void)endViewAnimated:(UIView *)view {
    self.customView.titleLb.text = @"这是标题";
    self.customView.textLb.text = @"这是内容";
    self.customView.imageView.image = [UIImage imageNamed:@"hanbing"];
    self.customView1.titleLb.text = @"这是标题";
    self.customView1.textLb.text = @"这是内容";
    self.customView1.imageView.image = [UIImage imageNamed:@"hanbing"];
    self.customView2.titleLb.text = @"这是标题";
    self.customView2.textLb.text = @"这是内容";
    self.customView2.imageView.image = [UIImage imageNamed:@"hanbing"];
    
    self.mainTV.startOrEndForSelfIsSuperView = NO;
    [self.mainTV reloadData];
    [[TZLLoadingViewAnimation shareLoadData] endSubViewAnimatedWithViews:@[self.customView, self.customView1, self.customView2]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.startOrEndForSelfIsSuperView == YES) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.startOrEndForSelfIsSuperView == YES) {
        return 5;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *str = @"TZLLoadingTableViewCell";
    TZLLoadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[TZLLoadingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (tableView.startOrEndForSelfIsSuperView == NO) {
        [[TZLLoadingViewAnimation shareLoadData] endSubViewAnimated:cell.contentView];
        cell.imageView1.image = [UIImage imageNamed:@"hanbing"];
        cell.titleLb.text = @"2222";
        cell.textLb.text = @"33333";
    }
    // 在加载动画的时候，即未获得数据时，不要走加载控件数据的方法
    
    
    return cell;
}
- (UITableView *)mainTV {
    if (!_mainTV) {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped]; // 开启动画
        [self.view addSubview:_mainTV];
        [_mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(self.customView2.mas_bottom).equalTo(10);
        }];
        _mainTV.startOrEndForSelfIsSuperView = YES;
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.rowHeight = 70;
        _mainTV.backgroundColor = [UIColor whiteColor];
        _mainTV.estimatedRowHeight = 0;
        _mainTV.estimatedSectionFooterHeight = 0;
        _mainTV.estimatedSectionHeaderHeight = 0;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTV registerClass:[TZLLoadingTableViewCell class] forCellReuseIdentifier:@"TZLLoadingTableViewCell"];
    }
    return _mainTV;
}
@end


@interface CustomView()
@end
@implementation CustomView
- (instancetype)init {
    if (self = [super init]) {
        [self textLb];
    }
    return self;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(15);
            make.size.equalTo(CGSizeMake(46, 46));
        }];
        _imageView.layer.cornerRadius = 23;
        _imageView.layer.masksToBounds = YES;
        
    }
    return _imageView;
}
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.mas_right).equalTo(10);
            make.top.equalTo(12);
            make.right.lessThanOrEqualTo(-12);
        }];
        _titleLb.font = [UIFont systemFontOfSize:15];
        _titleLb.animationStyle = TZLViewLoadAnimationStart;
        _titleLb.animationMode = TZLViewLoadAnimationModeToLong;
    }
    return _titleLb;
}
- (UILabel *)textLb {
    if (!_textLb) {
        _textLb = [[UILabel alloc] init];
        [self addSubview:_textLb];
        [_textLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.mas_right).equalTo(10);
            make.top.equalTo(self.titleLb.mas_bottom).equalTo(6);
            make.right.lessThanOrEqualTo(-12);
        }];
//        _textLb.text = @"11222";
        _textLb.font = [UIFont systemFontOfSize:15];
        _textLb.animationStyle = TZLViewLoadAnimationStart;
        _textLb.animationMode = TZLViewLoadAnimationModeToShort;
    }
    return _textLb;
}
@end
