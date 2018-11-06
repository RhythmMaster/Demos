//
//  TZLMyCardViewController.m
//  Demos
//
//  Created by tang on 2018/10/18.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLMyCardViewController.h"
#import "TZLCollectionViewWaterfallLayout.h"
#import "TZLWaterfallCollectionViewCell.h"
#import "TZLCustomTransformAnimation.h"
#import "TZLSubTransformViewController.h"

@interface TZLMyCardViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** collectionView */
@property(nonatomic, strong) UICollectionView *collectionView;
/**  */
@property(nonatomic, strong) NSArray *myArrs;


@end

@implementation TZLMyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myArrs = self.myCards.copy;
    [self collectionView];
    [self createUI];
    
}



/**
 *
 */
- (void)createUI {
    UIButton *threeStarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:threeStarBtn];
    [threeStarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-50);
        make.centerX.equalTo(self.view.mas_centerX).equalTo(-80);
    }];
    [threeStarBtn setTitle:@"3星" forState:UIControlStateNormal];
    [threeStarBtn setContentEdgeInsets:UIEdgeInsetsMake(6, 12, 6, 12)];
    threeStarBtn.backgroundColor = [UIColor blueColor];
    threeStarBtn.tag = 3;
    [threeStarBtn addTarget:self action:@selector(starAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *fourStarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:fourStarBtn];
    [fourStarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-50);
        make.centerX.equalTo(self.view.mas_centerX).equalTo(0);
    }];
    [fourStarBtn setTitle:@"4星" forState:UIControlStateNormal];
    [fourStarBtn setContentEdgeInsets:UIEdgeInsetsMake(6, 12, 6, 12)];
    fourStarBtn.backgroundColor = [UIColor blueColor];
    fourStarBtn.tag = 4;
    [fourStarBtn addTarget:self action:@selector(starAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *fiveStarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:fiveStarBtn];
    [fiveStarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-50);
        make.centerX.equalTo(self.view.mas_centerX).equalTo(80);
    }];
    [fiveStarBtn setTitle:@"5星" forState:UIControlStateNormal];
    [fiveStarBtn setContentEdgeInsets:UIEdgeInsetsMake(6, 12, 6, 12)];
    fiveStarBtn.backgroundColor = [UIColor blueColor];
    fiveStarBtn.tag = 5;
    [fiveStarBtn addTarget:self action:@selector(starAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *allStarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:allStarBtn];
    [allStarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-50);
        make.centerX.equalTo(self.view.mas_centerX).equalTo(160);
    }];
    [allStarBtn setTitle:@"全部" forState:UIControlStateNormal];
    [allStarBtn setContentEdgeInsets:UIEdgeInsetsMake(6, 12, 6, 12)];
    allStarBtn.backgroundColor = [UIColor blueColor];
    allStarBtn.tag = 12;
    [allStarBtn addTarget:self action:@selector(starAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)starAction:(UIButton *)sender {
    NSInteger tag = sender.tag;
    NSMutableArray *tmpArr = [NSMutableArray new];
    if (tag == 12) {
        tmpArr = self.myCards.mutableCopy;
    } else {
        for (NSInteger i = 0; i < self.myCards.count; i++) {
            NSString *star = [self.myCards[i] objectForKey:@"star"];
            if (star.integerValue == tag) {
                [tmpArr addObject:self.myCards[i]];
            }
        }
    }
    self.myArrs = tmpArr.copy;
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delete collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.myArrs.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZLWaterfallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZLWaterfallCollectionViewCell" forIndexPath:indexPath];
    NSString *name = [self.myArrs[indexPath.row] objectForKey:@"name"];
    NSString *star = [self.myArrs[indexPath.row] objectForKey:@"star"];
    cell.label.text = [NSString stringWithFormat:@"%@星%@", star, name];
    cell.backImageView.image = [UIImage imageNamed:name];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TZLWaterfallCollectionViewCell *cell = (TZLWaterfallCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = [collectionView convertRect:cell.frame toView:self.view];
    TZLSubTransformViewController *subVC = [TZLSubTransformViewController new];
    NSString *name = [self.myArrs[indexPath.row] objectForKey:@"name"];
    subVC.imageName = name;
    TZLNavigationController *naviVC = (TZLNavigationController *)self.navigationController;
    [naviVC pushViewController:subVC animationView:cell desRec:CGRectMake(100, 100, 250, 500) original:frame isPush:YES];
}


#pragma  mark lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        TZLCollectionViewWaterfallLayout *flowLayout = [[TZLCollectionViewWaterfallLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TZLWaterfallCollectionViewCell class] forCellWithReuseIdentifier:@"TZLWaterfallCollectionViewCell"];
    }
    return _collectionView;
}


@end
