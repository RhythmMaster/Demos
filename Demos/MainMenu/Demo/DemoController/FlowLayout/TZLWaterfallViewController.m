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
#import "TZLSubTransformViewController.h"

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
    [self.collectionView tzl_addHeadViewWithFrame:CGRectMake(0, 0, kScreenW, 150) view:self.stretchyHeadView];;
    [self collectionView];
    self.statusBarStyle = UIStatusBarStyleLightContent;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initNavigationViewWithBackgroundColor:[UIColor orangeColor] alpha:0.0 backImageName:@"" backText:@"" title:@""];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self reBackNavigation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - [self setNeedsStatusBarAppearanceUpdate]给这个方法就能回调到这里
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset_Y = scrollView.contentOffset.y;
//    NSLog(@"%f", offset_Y);
    //150是头部视图的高度 这里取值要固定好 不能通过self.stretchyHeadView.frame.size.height 取
    if (offset_Y >= -(150 + statusBarHeight)) {
        CGFloat alpha = (150 + statusBarHeight + offset_Y) / (150 - 44 - statusBarHeight);
        [self changeNaviBarAlpha:alpha];
        if (alpha > 0.5) {
            self.statusBarStyle = UIStatusBarStyleLightContent;
        } else {
            self.statusBarStyle = UIStatusBarStyleDefault;
        }
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TZLWaterfallCollectionViewCell *cell = (TZLWaterfallCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = [collectionView convertRect:cell.frame toView:self.view];
    TZLSubTransformViewController *subVC = [TZLSubTransformViewController new];
    [self.navigationController pushViewController:subVC animated:YES];
//    TZLNavigationController *naviVC = (TZLNavigationController *)self.navigationController;
//    [naviVC pushViewController:subVC animationView:cell desRec:CGRectMake(100, 100, 250, 500) original:frame isPush:YES];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        TZLCollectionViewWaterfallLayout *flowLayout = [[TZLCollectionViewWaterfallLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(-20);
        }];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TZLWaterfallCollectionViewCell class] forCellWithReuseIdentifier:@"TZLWaterfallCollectionViewCell"];
    }
    return _collectionView;
}
- (TZLStretchyHeadView *)stretchyHeadView {
    if (!_stretchyHeadView) {
        _stretchyHeadView = [[TZLStretchyHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
//        [self.collectionView addSubview:_stretchyHeadView];
    }
    return _stretchyHeadView;
}

@end
