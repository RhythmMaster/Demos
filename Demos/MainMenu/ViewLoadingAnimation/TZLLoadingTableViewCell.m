//
//  TZLLoadingTableViewCell.m
//  Demos
//
//  Created by tang on 2018/11/8.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLLoadingTableViewCell.h"

@implementation TZLLoadingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self textLb];
        [[TZLLoadingViewAnimation shareLoadData] startSubViewAnimated:self.contentView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView1];
        [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(15);
            make.size.equalTo(CGSizeMake(46, 46));
        }];
//        _imageView1.backgroundColor = [UIColor redColor];
        _imageView1.layer.cornerRadius = 23;
        _imageView1.layer.masksToBounds = YES;
        _imageView1.animationStyle = TZLViewLoadAnimationDefault;
        
    }
    return _imageView1;
}
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView1.mas_right).equalTo(10);
            make.top.equalTo(12);
            make.right.lessThanOrEqualTo(-12);
        }];
        _titleLb.font = [UIFont systemFontOfSize:15];
        _titleLb.animationStyle = TZLViewLoadAnimationStart;
        _titleLb.animationMode = TZLViewLoadAnimationModeToLong;
    }
    return _titleLb;
}
- (UILabel *)textLb {
    if (!_textLb) {
        _textLb = [[UILabel alloc] init];
        [self.contentView addSubview:_textLb];
        [_textLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView1.mas_right).equalTo(10);
            make.top.equalTo(self.titleLb.mas_bottom).equalTo(6);
            make.right.lessThanOrEqualTo(-12);
        }];
        //        _textLb.text = @"11222";
        _textLb.font = [UIFont systemFontOfSize:15];
        _textLb.animationStyle = TZLViewLoadAnimationStart;
        _textLb.animationMode = TZLViewLoadAnimationModeToShort;
    }
    return _textLb;
}
@end
