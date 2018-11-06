//
//  LHMakeRoleView.m
//  Demos
//
//  Created by tang on 2018/10/19.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "LHMakeRoleView.h"

@implementation LHMakeRoleView

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
- (void)createUI {
    UILabel *titleLb = [UILabel new];
    [self addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(80);
    }];
    titleLb.text = @"创建角色";
    
    UILabel *nameLb = [UILabel new];
    [self addSubview:nameLb];
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.top.equalTo(120);
    }];
    nameLb.text = @"角色名";
    
    UITextField *nameTF = [UITextField new];
    [self addSubview:nameTF];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLb.mas_right).equalTo(8);
        make.centerY.equalTo(nameLb.mas_centerY);
        make.width.equalTo(230);
    }];
    nameTF.layer.borderColor = [UIColor grayColor].CGColor;
    nameTF.layer.borderWidth = 1.0;
    nameTF.text = @"心境";
    
    UILabel *sexLb = [UILabel new];
    [self addSubview:sexLb];
    [sexLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.top.equalTo(nameLb.mas_bottom).equalTo(45);
    }];
    sexLb.text = @"选择性别";
    
    UIButton *manBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:manBtn];
    [manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sexLb.mas_right).equalTo(8);
        make.centerY.equalTo(sexLb.mas_centerY);
    }];
    [manBtn setTitle:@"男" forState:UIControlStateNormal];
    
    UIButton *womanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:womanBtn];
    [womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(manBtn.mas_right).equalTo(8);
        make.centerY.equalTo(manBtn.mas_centerY);
    }];
    [womanBtn setTitle:@"女" forState:UIControlStateNormal];
    
    //    UILabel *careerLb = [UILabel new];
    //    [self.view addSubview:careerLb];
    //    [careerLb mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(30);
    //        make.top.equalTo(nameLb.mas_bottom).equalTo(45);
    //    }];
    //    careerLb.text = @"选择职业";
    //
    //    UIButton *manBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    //    [self.view addSubview:manBtn];
    //    [manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(sexLb.mas_right).equalTo(8);
    //        make.centerY.equalTo(sexLb.mas_centerY);
    //    }];
    //    [manBtn setTitle:@"男" forState:UIControlStateNormal];
    //
    //    UIButton *womanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    //    [self.view addSubview:womanBtn];
    //    [womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(manBtn.mas_right).equalTo(8);
    //        make.centerY.equalTo(manBtn.mas_centerY);
    //    }];
    //    [womanBtn setTitle:@"女" forState:UIControlStateNormal];
    
    
    UIButton *startGameBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:startGameBtn];
    [startGameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(8);
        make.bottom.equalTo(-30);
    }];
    [startGameBtn setTitle:@"开始游戏" forState:UIControlStateNormal];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
@end
