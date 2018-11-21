//
//  UITableView+TZLExtension.m
//  Demos
//
//  Created by tang on 2018/11/21.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "UITableView+TZLExtension.h"
#import <objc/runtime.h>

static NSString *orininalFrame = @"orininalFrame";
static NSString *orininalHeadView = @"orininalHeadView";

@implementation UITableView (TZLExtension)
- (void)tzl_addHeadViewWithFrame:(CGRect)frame view:(UIView *)view {
    // 创建关联
    objc_setAssociatedObject(self, &orininalFrame, NSStringFromCGRect(frame), OBJC_ASSOCIATION_RETAIN);
    
    //占位用,不用自己去设置contentoffset
    UIView *placeholderHeadView = [[UIView alloc] initWithFrame:frame];
    self.tableHeaderView = placeholderHeadView;
    
    UIView *headView = view;
    headView.frame = frame;
    [self insertSubview:headView atIndex:0];
    objc_setAssociatedObject(self, &orininalHeadView, headView, OBJC_ASSOCIATION_RETAIN);
    
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        NSValue *newValue = change[NSKeyValueChangeNewKey];
        CGPoint contentOffset = newValue.CGPointValue;
        //FIXME:重点说明:  利用观察者模式 比在scrollView 代理方法里面要更加精确 ,不会出现视图更新跟不上的情况 比如上滑过快导致 顶部瞬间出现的空白情况
        [self updateOriginWithOffset:contentOffset];
    }
}

- (void)updateOriginWithOffset:(CGPoint)offset {
    CGFloat offSet_Y = offset.y;
    UIView *headView = objc_getAssociatedObject(self, &orininalHeadView);
    CGRect originalRect = CGRectFromString(objc_getAssociatedObject(self, &orininalFrame));
    CGRect frame = headView.frame;
    frame.origin.y = offSet_Y + statusBarHeight;
    if (offSet_Y >= -statusBarHeight) {
        frame.origin.x = originalRect.origin.x;
        frame.size.width = originalRect.size.width;
    } else {
        frame.origin.x = offSet_Y + statusBarHeight;
        frame.size.width = originalRect.size.width - 2 * (offSet_Y + statusBarHeight);
    }
    frame.size.height = originalRect.size.height - (offSet_Y + statusBarHeight);
    headView.frame = frame;
}
@end
