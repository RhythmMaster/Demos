//
//  TZLCustomScrollerView.m
//  Demos
//
//  Created by tang on 2018/12/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLCustomScrollerView.h"

@interface TZLCustomScrollerView ()
/**  */
@property(nonatomic, assign) CGPoint startPoint;


@end

@implementation TZLCustomScrollerView

- (instancetype)init {
    if (self = [super init]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}
- (void)panAction:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startPoint = self.bounds.origin;      
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [pan translationInView:self];
        CGRect bounds = self.bounds;
        CGFloat new_X = MAX(0, self.startPoint.x - point.x);
        new_X = self.startPoint.x - point.x;
        CGFloat new_Y = MAX(0, self.startPoint.y - point.y);
        new_Y = self.startPoint.y - point.y;
        bounds = CGRectMake(new_X, new_Y, bounds.size.width, bounds.size.height);
        NSLog(@"%@", NSStringFromCGRect(bounds));
        self.bounds = bounds;
    }
}
@end
