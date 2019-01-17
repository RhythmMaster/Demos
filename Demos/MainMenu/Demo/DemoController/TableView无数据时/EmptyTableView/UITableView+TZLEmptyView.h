//
//  UITableView+TZLEmptyView.h
//  Demos
//
//  Created by tang on 2019/1/10.
//  Copyright © 2019年 TZL. All rights reserved.
//
//第一种思路:利用 tzl_emptyReload 方法去刷新 在刷新之前 可以通过对DataSource判断 有无数据
// 优点: 不用去使用swizz 方法交换
// 缺点: 缺点比较明显,所有的 reload 方法都得换成 tzl_emptyReload 方法 如果是新项目还好 在写的时候 自己注意 使用tzl_emptyReload就好了 ,但如果是老项目的话 要替换 很多reload 这个 不光工作量增加 还可能有些没修改到 ,所以有了第二种思路
//第二种思路:使用swizz 方法交换

//FIXME:使用第一种的时候记得把swizz的交换代码注释了

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^tzl_emptyBtnBlock)(void);

@interface UITableView (TZLEmptyView)

/** 判断是否当数据为空的时候添加空view 使用第一种方式的时候不需要设置 */
@property(nonatomic, assign) BOOL tzl_haveEmpty;

//支持自定义noteView
@property (nonatomic) UIView * emptyNoteView;

/**  */
@property(nonatomic, copy) tzl_emptyBtnBlock tzl_emptyBtnBlock;

- (void)tzl_emptyReload;
@end

NS_ASSUME_NONNULL_END
