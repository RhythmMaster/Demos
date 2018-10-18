//
//  DrawCardViewController.m
//  DemoSet
//
//  Created by tang on 2018/10/18.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "DrawCardViewController.h"
#import "TZLMyCardViewController.h"

@interface DrawCardViewController ()
/**  */
@property(nonatomic, strong) UILabel *starLb;
/**  */
@property(nonatomic, strong) UIImageView *cardImage;
/**  */
@property(nonatomic, copy) NSArray *cardArr;
/** 我抽到的卡 */
@property(nonatomic, strong) NSMutableArray *myCardArr;
@end

@implementation DrawCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *drawCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:drawCardBtn];
    [drawCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.bottom.equalTo(-20);
    }];
    [drawCardBtn setTitle:@"抽个试试" forState:UIControlStateNormal];
    [drawCardBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [drawCardBtn addTarget:self action:@selector(drawCardAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *starLb = [UILabel new];
    [self.view addSubview:starLb];
    [starLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(100);
    }];
    self.starLb = starLb;
    
    UIImageView *image = [UIImageView new];
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.size.equalTo(CGSizeMake(220, 336));
    }];
    self.cardImage = image;
    
    [self getCard];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *myCards = [userDefaults objectForKey:@"myCardArr"];
    if (!myCards) {
        myCards = [NSMutableArray new];
    }
    self.myCardArr = [myCards mutableCopy];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] createBarItemWithImageName:@"1" name:@"我的武将" target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)getCard {
    NSDictionary *cardDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"STZBCard" ofType:@"plist"]];
    NSArray *cardArr = [cardDict valueForKey:@"Cards"];
    self.cardArr = cardArr;
}

- (void)drawCardAction:(UIButton *)sender {
    int x = arc4random() % (self.cardArr.count * 10);
    if (x < self.cardArr.count) {//5星将
        NSString *name = [self.cardArr[x] objectForKey:@"name"];
        self.starLb.text = [NSString stringWithFormat:@"5星%@ %d", name, x];;
        self.cardImage.image = [UIImage imageNamed:name];
        NSLog(@"5星%@ %d", name, x);
        [self.myCardArr addObject:self.cardArr[x]];
    } else if (x >= self.cardArr.count && x <= self.cardArr.count * 3) {
        NSLog(@"4星%d", x);
        self.starLb.text = [NSString stringWithFormat:@"4星%d", x];
        self.cardImage.image = [UIImage imageNamed:@"direction"];
        [self.myCardArr addObject:self.cardArr[90]];
    } else {
        NSLog(@"3星%d", x);
        self.starLb.text = [NSString stringWithFormat:@"3星%d", x];
        self.cardImage.image = [UIImage imageNamed:@"direction"];
        [self.myCardArr addObject:self.cardArr[91]];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.myCardArr forKey:@"myCardArr"];
    [userDefaults synchronize];
    
}
- (void)rightAction:(UIButton *)sender {
    TZLMyCardViewController *myCardVC = [TZLMyCardViewController new];
    myCardVC.myCards = self.myCardArr.copy;
    [self.navigationController pushViewController:myCardVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
