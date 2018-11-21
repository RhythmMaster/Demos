//
//  TZLSignRecordTVCell.m
//  Demos
//
//  Created by tang on 2018/11/12.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLSignRecordTVCell.h"

static NSInteger marginLeft = 60;
static NSInteger marginRight = 0;
static NSInteger marginBottom = -16;

//FIXME: 签到日期cell
@interface TZLSignRecordTVCell ()
/**  */
@property(nonatomic, strong) UIView *dateBackView;
/**  */
@property(nonatomic, strong) UIImageView *stepImage;
/**  */
@property(nonatomic, strong) UIView *locationBackView;
/**  */
@property(nonatomic, strong) UIImageView *locationImg;
/**  */
@property(nonatomic, strong) UIView *stepLineView;

@end

@implementation TZLSignRecordTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = tab_kBackColor;
        [self dateLb];
        [self locationLb];
        [self stepImage];
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
#pragma  mark setter
- (void)setHideStepLine:(BOOL)hideStepLine {
    _hideStepLine = hideStepLine;
    self.stepLineView.hidden = hideStepLine;
}
#pragma  mark lazy
- (UIView *)dateBackView {
    if (!_dateBackView) {
        _dateBackView = [[UIView alloc] init];
        [self.contentView addSubview:_dateBackView];
        [_dateBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.right.equalTo(marginRight);
            make.height.equalTo(40);
            make.left.equalTo(marginLeft);
        }];
        _dateBackView.backgroundColor = [UIColor whiteColor];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(-6, 20)];
        [path addLineToPoint:CGPointMake(0, 15)];
        [path addLineToPoint:CGPointMake(0, 25)];
        [path addLineToPoint:CGPointMake(-6, 20)];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor whiteColor].CGColor;
        [_dateBackView.layer addSublayer:layer];

        
        UIView *lineView = [[UIView alloc] init];
        [_dateBackView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(1);
        }];
        lineView.backgroundColor = tab_kBackColor;
    }
    return _dateBackView;
}

- (UILabel *)dateLb {
    if (!_dateLb) {
        _dateLb = [[UILabel alloc] init];
        [self.dateBackView addSubview:_dateLb];
        [_dateLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(15);
        }];
        _dateLb.text = @"2018-11-12    11:20:12";
    }
    return _dateLb;
}

- (UIView *)locationBackView {
    if (!_locationBackView) {
        _locationBackView = [[UIView alloc] init];
        [self.contentView addSubview:_locationBackView];
        [_locationBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dateBackView.mas_bottom).equalTo(0);
            make.right.equalTo(marginRight);
            make.left.equalTo(marginLeft);
            make.bottom.equalTo(marginBottom);
        }];
        _locationBackView.backgroundColor = [UIColor whiteColor];
    }
    return _locationBackView;
}
- (UIImageView *)locationImg {
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc] init];
        [self.locationBackView addSubview:_locationImg];
        [_locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.top.equalTo(10);
            make.size.equalTo(CGSizeMake(20, 20));
        }];
        _locationImg.image = [UIImage imageNamed:@"location"];
    }
    return _locationImg;
}
- (UILabel *)locationLb {
    if (!_locationLb) {
        _locationLb = [[UILabel alloc] init];
        [self.locationBackView addSubview:_locationLb];
        [_locationLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.locationImg.mas_right).equalTo(6);
            make.top.equalTo(self.locationImg.mas_top).equalTo(0);
            make.right.equalTo(-15);
            make.bottom.equalTo(-10);
        }];
        _locationLb.textColor = [UIColor lightGrayColor];
        _locationLb.font = [UIFont systemFontOfSize:13.9];
        _locationLb.numberOfLines = 0;
        _locationLb.text = @"什么位置什么位置什么位置什么位置什么位置什么位置什么位置什么位置什么位置什么位置什么位置什么位置什么位置什么位置什么位置";
        
    }
    return _locationLb;
}

- (UIImageView *)stepImage {
    if (!_stepImage) {
        _stepImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_stepImage];
        [_stepImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.dateBackView.mas_centerY);
            make.centerX.equalTo(self.contentView.mas_left).equalTo(marginLeft * 0.5);
        }];
        _stepImage.image = [UIImage imageNamed:@"completed_icon_com"];
        
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        WK(weakSelf);
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_left).equalTo(marginLeft * 0.5);
            make.top.equalTo(weakSelf.stepImage.mas_bottom);
            make.width.equalTo(1);
            make.bottom.equalTo(12);
        }];
        lineView.backgroundColor = kRGBA(199, 199, 199, 1.0);
        self.stepLineView = lineView;
    }
    return _stepImage;
}

@end


//FIXME: 签到位置cell
@interface TZLSignRecordMoreTVCell ()
/**  */
@property(nonatomic, strong) UIView *backView;
/**  */
@property(nonatomic, strong) UIImageView *stepImage;
@end

@implementation TZLSignRecordMoreTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = tab_kBackColor;
        [self moreLb];
        [self stepImage];
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

#pragma  mark lazy
- (UIView *)backView {
    if (!_backView) {
        
        _backView = [[UIView alloc] init];
        [self.contentView addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.right.equalTo(marginRight);
            make.height.equalTo(40);
            make.left.equalTo(marginLeft);
        }];
        _backView.backgroundColor = [UIColor whiteColor];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(-6, 20)];
        [path addLineToPoint:CGPointMake(0, 15)];
        [path addLineToPoint:CGPointMake(0, 25)];
        [path addLineToPoint:CGPointMake(-6, 20)];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor whiteColor].CGColor;
        [_backView.layer addSublayer:layer];
    }
    return _backView;
}

- (UILabel *)moreLb {
    if (!_moreLb) {
        _moreLb = [[UILabel alloc] init];
        [self.backView addSubview:_moreLb];
        [_moreLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.bottom.equalTo(-10);
            make.left.equalTo(15);
        }];
        _moreLb.textColor = [UIColor lightGrayColor];
        _moreLb.font = [UIFont systemFontOfSize:14.5];
        _moreLb.numberOfLines = 0;
        _moreLb.text = @"查看更多>>";
        
    }
    return _moreLb;
}
- (UIImageView *)stepImage {
    if (!_stepImage) {
        _stepImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_stepImage];
        [_stepImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backView.mas_centerY);
            make.centerX.equalTo(self.contentView.mas_left).equalTo(marginLeft * 0.5);
        }];
        _stepImage.image = [UIImage imageNamed:@"completed_icon_com"];

    }
    return _stepImage;
}
@end
