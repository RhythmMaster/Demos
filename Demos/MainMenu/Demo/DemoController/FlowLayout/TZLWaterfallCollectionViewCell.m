//
//  TZLWaterfallCollectionViewCell.m
//  Demos
//
//  Created by tang on 2018/9/11.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLWaterfallCollectionViewCell.h"

@implementation TZLWaterfallCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self backImageView];
        [self label];
    }
    return self;
}
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        [self.contentView addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _backImageView.image = [UIImage imageNamed:@"direction"];
    }
    return _backImageView;
}
- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
    }
    return _label;
}
@end
