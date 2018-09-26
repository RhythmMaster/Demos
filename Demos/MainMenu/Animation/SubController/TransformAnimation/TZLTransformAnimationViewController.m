//
//  TZLTransformAnimationViewController.m
//  Demos
//
//  Created by tang on 2018/9/26.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLTransformAnimationViewController.h"
#import "TZLCollectionViewWaterfallLayout.h"
#import "TZLWaterfallCollectionViewCell.h"

#import "TZLSubTransformViewController.h"

#import "TZLCustomTransformAnimation.h"

@interface TZLTransformAnimationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** collectionView */
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TZLTransformAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView];
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
