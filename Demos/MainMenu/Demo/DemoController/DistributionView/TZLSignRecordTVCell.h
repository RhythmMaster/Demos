//
//  TZLSignRecordTVCell.h
//  Demos
//
//  Created by tang on 2018/11/12.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//FIXME: 签到日期cell
@interface TZLSignRecordTVCell : UITableViewCell
/**  */
@property(nonatomic, strong) UILabel *dateLb;
/**  */
@property(nonatomic, strong) UILabel *locationLb;

/** 是否隐藏每步对应的灰色线 一般是最后一个cell使用 需要隐藏 */
@property(nonatomic, assign) BOOL hideStepLine;
@end

//FIXME: 签到位置cell
@interface TZLSignRecordMoreTVCell : UITableViewCell
/**  */
@property(nonatomic, strong) UILabel *moreLb;
@end

NS_ASSUME_NONNULL_END
