//
//  UIViewController+TZLCusNavigation.m
//  Demos
//
//  Created by tang on 2018/11/20.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "UIViewController+TZLCusNavigation.h"
@interface UIViewController()
/**  */
@property(nonatomic, strong) TZLCusNavigationView *naviView;
/**  */
@property(nonatomic, strong) UIView *snapshotView;
@end
@implementation UIViewController (TZLCusNavigation)
- (void)initNavigationViewWithBackgroundColor:(UIColor *)backgroundColor alpha:(CGFloat)alpha backImageName:(NSString *)backImageName backText:(NSString *)backText title:(NSString *)title {
    CGFloat height = kScreenH > 736.0 ? (88.0) : (64.0);
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self snapshotLastView];
    if (!self.naviView) {
        TZLCusNavigationView *naviView = [[TZLCusNavigationView alloc] initViewWithFrame:CGRectMake(0, 0, kScreenW, height) backgroundColor:backgroundColor alpha:alpha backImageName:backImageName backText:backText title:title];
        [self.view addSubview:naviView];
        WK(weakSelf);
        naviView.backBlock = ^(UIButton * _Nonnull sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        self.naviView = naviView;
        
        UIScreenEdgePanGestureRecognizer *gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
        gestureRecognizer.edges = UIRectEdgeLeft;
//        [self.view addGestureRecognizer:gestureRecognizer];
    }
}
- (void)reBackNavigation {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)changeNaviBarAlpha:(CGFloat)alpha {
    alpha = MIN(1, MAX(alpha, 0));
    self.naviView.alpha = alpha;
}
- (void)gestureAction:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer {
    CGFloat offsetX = [gestureRecognizer translationInView:self.view].x;
    CGFloat alpha = offsetX / kScreenW;
    alpha = MIN(1.0, MAX(0.0, alpha));
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        // 开始位移
        self.view.transform = CGAffineTransformMakeTranslation(offsetX, 0);
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        if (alpha >= 0.3) {
            [self scrollBack];
        } else {
            // 恢复原样
            [UIView animateWithDuration:0.3 animations:^{
                self.view.transform = CGAffineTransformIdentity;
            }];
        }
    }
    
}
- (void)scrollBack {
    UIView *snapshotView = self.snapshotView;
    snapshotView.hidden = YES;
    [snapshotView removeFromSuperview];
    self.snapshotView = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self.naviView removeFromSuperview];
    self.naviView = nil;
}
- (void)snapshotLastView {
    if (self.snapshotView) {
        return;
    }
    CGFloat height = kScreenH > 736.0 ? (88.0) : (64.0);
    UIImage *lastNaviView = [self.navigationController.navigationBar snapshotImageAfterScreenUpdates:NO];
    lastNaviView = [lastNaviView stretchableImageWithLeftCapWidth:0 topCapHeight:1];
    UIImageView *imageView = [UIImageView new];
    imageView.image = lastNaviView;
    imageView.frame = CGRectMake(0, 0, kScreenW, height);
    
    NSLog(@"%ld", [self.navigationController.viewControllers indexOfObject:self]);
    UIViewController *VC = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers indexOfObject:self] - 1];
    UIView *snapshotView = [VC.view snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = CGRectMake(-kScreenW, 0, kScreenW, kScreenH);
    [snapshotView addSubview:imageView];
    [self.view addSubview:snapshotView];
    self.snapshotView = snapshotView;
}

- (void)setNaviView:(TZLCusNavigationView *)naviView {
    objc_setAssociatedObject(self, @selector(naviView), naviView, OBJC_ASSOCIATION_RETAIN);
}
- (TZLCusNavigationView *)naviView {
    return objc_getAssociatedObject(self, @selector(naviView));
}
- (void)setSnapshotView:(UIView *)snapshotView {
    objc_setAssociatedObject(self, @selector(snapshotView), snapshotView, OBJC_ASSOCIATION_RETAIN);
}
- (UIView *)snapshotView {
    return objc_getAssociatedObject(self, @selector(snapshotView));
}
@end
@implementation TZLCusNavigationView

- (instancetype)initViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor alpha:(CGFloat)alpha backImageName:(NSString *)backImageName backText:(NSString *)backText title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = backgroundColor;
        self.alpha = alpha;
        [self initUI];
        
        if (backText && backText.length) {
            [self.backBtn setTitle:[NSString stringWithFormat:@" %@", backText] forState:UIControlStateNormal];
        }
        if (backImageName && backImageName.length) {
            [self.backBtn setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
        }
        if (backImageName && backImageName.length) {
            self.titleLb.text = title;
        }
       
    }
    return self;
}
- (void)initUI {
    [self backBtn];
    [self titleLb];
}

#pragma  mark lazy
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(8);
            make.bottom.equalTo(-6);
            make.height.equalTo(30);
        }];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_backBtn setTitle:@" 返回" forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        _backBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 8, 6, 8);
        [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (void)backAction:(UIButton *)sender {
    self.backBlock(sender);
}
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.centerY.equalTo(self.mas_bottom).equalTo(-22);
        }];
        _titleLb.text = @"这是标题";
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.font = [UIFont systemFontOfSize:15];
    }
    return _titleLb;
}
@end
