//
//  TZLWaterfallViewController.m
//  Demos
//
//  Created by tang on 2018/9/11.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLWaterfallViewController.h"
#import "TZLCollectionViewWaterfallLayout.h"
#import "TZLWaterfallCollectionViewCell.h"

#import "TZLStretchyHeadView.h"

@interface TZLWaterfallViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** collectionView */
@property(nonatomic, strong) UICollectionView *collectionView;
/** 可伸展的头部 */
@property(nonatomic, strong) TZLStretchyHeadView *stretchyHeadView;
/** 控制当前状态栏 */
@property (nonatomic,assign) UIStatusBarStyle statusBarStyle;
@end

@implementation TZLWaterfallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - [self setNeedsStatusBarAppearanceUpdate]给这个方法就能回调到这里
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tzl_navigationBarBackgroundAlpha = 0.f;
    [self collectionView];
    self.stretchyHeadView = [[TZLStretchyHeadView alloc] initWithFrame:CGRectMake(0, -164, self.view.width, 164)];
    [self.collectionView addSubview:self.stretchyHeadView];
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

#pragma mark delete collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 46;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZLWaterfallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZLWaterfallCollectionViewCell" forIndexPath:indexPath];
    cell.label.text = @(indexPath.row).stringValue;
    return cell;
}

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
