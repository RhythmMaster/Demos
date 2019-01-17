//
//  TZLEmptyTableViewVC.m
//  Demos
//
//  Created by tang on 2019/1/10.
//  Copyright © 2019年 TZL. All rights reserved.
// 这是在mrc环境下

#import "TZLEmptyTableViewVC.h"
#import "UITableView+TZLEmptyView.h"

@interface TZLEmptyTableViewVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView * tableView;

@property (nonatomic) NSInteger numberOfSections;

@end

@implementation TZLEmptyTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numberOfSections = 5;
    [self.tableView reloadData];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] createBarItemWithImageName:@"" name:@"减一个" target:self action:@selector(reduce)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] createBarItemWithImageName:@"" name:@"加一个" target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)reduce {
    self.numberOfSections --;
    if (self.numberOfSections < 0) {
        self.numberOfSections = 0;
    }
    [self.tableView reloadData];
}
- (void)add {
    self.numberOfSections ++;
    [self.tableView reloadData];
}

#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 0;
    }
    return ((section % 2) == 0) ? 1 : 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = ((indexPath.row % 2) == 0) ? [UIColor orangeColor]: [UIColor greenColor];
    return cell;
}

#pragma  mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        // Do any additional setup after loading the view, typically from a nib.
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tzl_haveEmpty = YES;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        WK(weakSelf);
        _tableView.tzl_emptyBtnBlock = ^{
            NSLog(@"%@", NSStringFromCGRect(weakSelf.view.frame));
        };
        NSLog(@"%@", _tableView.tzl_emptyBtnBlock);
        NSLog(@"%ld", self.retainCount);
        //为11  如果将 _tableView.tzl_emptyBtnBlock = ^{
        //NSLog(@"%@", NSStringFromCGRect(self.view.frame));
        //}; 里面的NSLog(@"%@", NSStringFromCGRect(self.view.frame));  不用 则为10  说明tzl_emptyBtnBlock 强引用了 self  会存在 无法释放self 的问题  或者将self 改为weakSelf 弱引用也可以
    }
    return _tableView;
}
@end
