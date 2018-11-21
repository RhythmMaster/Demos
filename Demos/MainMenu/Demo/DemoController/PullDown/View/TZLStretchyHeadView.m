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
/**  */
@property(nonatomic, assign) CGRect originalRect;
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
        self.originalRect = frame;
        [self backImageView];
    }
    return self;
}

#pragma  mark lazy
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.image = [UIImage imageNamed:@"hanbing"];
        [self addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _backImageView;
}
@end
