//
//  TZLStretchyHeadView.m
//  Demos
//
//  Created by tang on 2018/9/6.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLStretchyHeadView.h"

@interface TZLStretchyHeadView()
/** 父视图 (滚动视图) */
@property(nonatomic, strong) UIScrollView *superScrollView;
@end
@implementation TZLStretchyHeadView

- (instancetype)init {
    if (self = [super init]) {
        [self backImageView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self backImageView];
    }
    return self;
}
- (void)didMoveToSuperview {
    //只针对默认情况的半透明的导航栏
    self.superScrollView = (UIScrollView *)self.superview;
    CGFloat contentInset_Top = self.frame.size.height - 64;
    self.superScrollView.contentInset = UIEdgeInsetsMake(contentInset_Top, 0, 0, 0);
    
    [self.superScrollView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSValue *newValue = change[NSKeyValueChangeNewKey];
    CGPoint contentOffset = newValue.CGPointValue;
    //FIXME:重点说明:  利用观察者模式 比在scrollView 代理方法里面要更加精确 ,不会出现视图更新跟不上的情况 比如上滑过快导致 顶部瞬间出现的空白情况
    [self updateOriginWithOffset:contentOffset];
}

- (void)updateOriginWithOffset:(CGPoint)offset {
    CGFloat offSet_Y = offset.y;
    NSLog(@"scrollView.contentOffset: %@", NSStringFromCGPoint(offset));
    CGRect frame = self.frame;
    UIViewController *superVC = [self.superScrollView viewController];
    frame.origin.y = offSet_Y;
    frame.size.height = -offSet_Y;
    if (offSet_Y >= -128 && offSet_Y <= -64) {
        CGFloat alpha = (offSet_Y + 128) / 64;
        superVC.tzl_navigationBarBackgroundAlpha = alpha;
    }
    if (offSet_Y >= -64) {
        superVC.tzl_navigationBarBackgroundAlpha = 1.0f;//确保拉的过快的情况
    }
    if (offSet_Y < -128) {
        superVC.tzl_navigationBarBackgroundAlpha = 0;//确保拉的过快的情况
    }
    if (offSet_Y < -228) {
        frame.size.width = self.superScrollView.width + (-offSet_Y - 228);
    }
    self.frame = frame;
    NSLog(@"self.headView.frame: %@", NSStringFromCGRect(self.frame));
    NSLog(@"%s", __func__);
}

#pragma  mark lazy
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.image = [UIImage imageNamed:@"direction"];
        [self addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _backImageView;
}
@end
