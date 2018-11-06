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
/**  */
@property(nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation DrawCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *clearCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:clearCardBtn];
    [clearCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-20);
        make.top.equalTo(100);
    }];
    [clearCardBtn setTitle:@"清空我的卡包" forState:UIControlStateNormal];
    [clearCardBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [clearCardBtn addTarget:self action:@selector(clearCardAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
    image.image = [UIImage imageNamed:@"tree"];
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
    
    // 1.根据Entity名称和NSManagedObjectContext获取一个新的继承于NSManagedObject的子类Student
    
    General * general = [NSEntityDescription
                         insertNewObjectForEntityForName:@"General"
                         inManagedObjectContext:self.context];
    NSInteger allCard = self.cardArr.count * 3;
    int x = arc4random() % (allCard);
    
    if (x < self.cardArr.count) {//4,5星将
        NSString *name = [self.cardArr[x] objectForKey:@"name"];
        NSString *star = [self.cardArr[x] objectForKey:@"star"];
        self.starLb.text = [NSString stringWithFormat:@"%@星%@ %d", star, name, x];
        [UIView transitionWithView:self.cardImage duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            self.cardImage.image = [UIImage imageNamed:name];
        } completion:^(BOOL finished) {
            
        }];
        
        NSLog(@"%@星%@ %d", star, name, x);
        [self.myCardArr addObject:self.cardArr[x]];
        
        general.name = name;
        general.star = star;
        
    } else {
        NSLog(@"3星 %d", x);
        self.starLb.text = [NSString stringWithFormat:@"3星 %d", x];
        self.cardImage.image = [UIImage imageNamed:@"direction"];
        [self.myCardArr addObject:self.cardArr[211]];
        
        general.name = @"direction";
        general.star = @"3";
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.myCardArr forKey:@"myCardArr"];
    [userDefaults synchronize];
    
    //查询所有数据的请求
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"General"];
//    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    //   3.保存插入的数据
    NSError *error = nil;
    if ([_context save:&error]) {
//        [self alertViewWithMessage:@"数据插入到数据库成功"];
    }else{
        [self alertViewWithMessage:[NSString stringWithFormat:@"数据插入到数据库失败, %@",error]];
    }
}

- (void)clearCardAction:(UIButton *)sender {
    [self.myCardArr removeAllObjects];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.myCardArr forKey:@"myCardArr"];
    [userDefaults synchronize];
}

//插入数据
- (void)insertData{
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

- (NSManagedObjectContext *)context {
    if (!_context) {
        _context = [TZLCoreDataManager getManagedObjectContext];
    }
    return _context;
}

@end
