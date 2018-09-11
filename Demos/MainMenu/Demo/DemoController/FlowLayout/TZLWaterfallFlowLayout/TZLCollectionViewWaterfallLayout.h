//
//  TZLCollectionViewWaterfallLayout.h
//  Demos
//
//  Created by tang on 2018/9/11.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZLCollectionViewWaterfallLayout : UICollectionViewLayout
/** 一行几列,Default: 2 */
@property(nonatomic, assign) NSInteger column;
/** 整体edgeInsets,Default:UIEdgeInsetsZero */
@property(nonatomic, assign) UIEdgeInsets sectionInset;
/** 列间距,最小10 */
@property(nonatomic, assign) CGFloat columnSpacing;
/** 行间距,最小10 */
@property(nonatomic, assign) CGFloat lineSpacing;
@end
