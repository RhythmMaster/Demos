//
//  TZLLoadingViewAnimation.m
//  Demos
//
//  Created by tang on 2018/11/8.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLLoadingViewAnimation.h"


static CGFloat defaultDuration = 0.4f;
static CGFloat defaultHeight = 20.f;           // use to label with row is not one
//static CGFloat defaultSpaceWithLines = 10.f;   // use to label with row is not one

@implementation TZLLoadingViewAnimation
+ (instancetype)shareLoadData {
    static TZLLoadingViewAnimation *singleData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleData = [[TZLLoadingViewAnimation alloc] init];
    });
    return singleData;
}
- (instancetype)init {
    if (self = [super init]) {
        _animatedDuration = defaultDuration;
        _animatedColor = tab_kBackColor;
        _longToValue = 1.5;
        _shortToValue = 0.5;
    }
    return self;
}

- (void)startOrEndViewAnimated:(UIView *)view {
    for (NSInteger i = 0; i < view.subviews.count; i++) {
        UIView *subView = view.subviews[i];
        switch (subView.animationStyle) {
            case TZLViewLoadAnimationDefault: {
                [self changeFrameWithView:subView withSuperView:view];
                [self addAnimationLayerWithView:subView animated:NO];
                break;
            }
            case TZLViewLoadAnimationStart: {
                [self changeFrameWithView:subView withSuperView:view];
                [self addAnimationLayerWithView:subView animated:YES];
                break;
            }
            case TZLViewLoadAnimationEnd: {
                NSArray<CALayer *> *subLayers = subView.layer.sublayers;
                subView.animationStyle = TZLViewLoadAnimationNO;
                [self removeSubLayers:subLayers];
                break;
            }
            default:
                break;
        }
        
    }
}
- (void)startOrEndViewAnimatedWithViews:(NSArray<UIView *> *)views {
    if (views && views.count) {
        for (NSInteger i = 0; i < views.count; i++) {
            UIView *view = views[i];
            [self startOrEndViewAnimated:view];
        }
    }
}
- (void)startSubViewAnimated:(UIView *)view {
    
    for (NSInteger i = 0; i < view.subviews.count; i++) {
        UIView *subView = view.subviews[i];
        subView.animationStyle = [self changeFrameWithView:subView withSuperView:view] ? TZLViewLoadAnimationStart: TZLViewLoadAnimationDefault;
        //        NSLog(@"%d", subView.isStart);
        switch (subView.animationStyle) {
            case TZLViewLoadAnimationDefault: {
                [self addAnimationLayerWithView:subView animated:NO];
                break;
            }
            case TZLViewLoadAnimationStart: {
                [self addAnimationLayerWithView:subView animated:YES];
                break;
            }
            default:
                break;
        }
    }
    
}
- (void)startSubViewAnimatedWithViews:(NSArray<UIView *> *)views {
    if (views && views.count) {
        for (NSInteger i = 0; i < views.count; i++) {
            UIView *view = views[i];
            [self startSubViewAnimated:view];
        }
    }
}
- (void)endSubViewAnimated:(UIView *)view {
    for (NSInteger i = 0; i < view.subviews.count; i++) {
        UIView *subView = view.subviews[i];
        subView.animationStyle = TZLViewLoadAnimationNO;
        NSArray<CALayer *> *subLayers = subView.layer.sublayers;
        [self removeSubLayers:subLayers];
    }
    
}
- (void)endSubViewAnimatedWithViews:(NSArray<UIView *> *)views {
    if (views && views.count) {
        for (NSInteger i = 0; i < views.count; i++) {
            UIView *view = views[i];
            [self endSubViewAnimated:view];
        }
    }
}
- (void)addAnimationLayerWithView:(UIView *)subView animated:(BOOL)animated {
    CALayer *layer = [[CALayer alloc]init];
    layer.frame = CGRectMake(0, 0, subView.frame.size.width, subView.frame.size.height);
    layer.backgroundColor = tab_kBackColor.CGColor;
    layer.anchorPoint = CGPointMake(0, 0);
    layer.position = CGPointMake(0, 0);
    layer.name = @"TABLayer";
    if (animated) {
        if ([subView isKindOfClass:[UILabel class]]) {
            CGFloat scale_X = 0.6;
            if (subView.animationMode == TZLViewLoadAnimationModeToLong) {
                scale_X = 1;
            } else if (subView.animationMode == TZLViewLoadAnimationModeToShort) {
                scale_X = 0;
            }
            [layer addAnimation:[self scaleXAnimationWithScale_X:scale_X] forKey:@"scaleAnimation"];
        }
    }
    [subView.layer addSublayer:layer];
}
- (BOOL)changeFrameWithView:(UIView *)view withSuperView:(UIView *)superView {
//    NSLog(@"%@", NSStringFromCGRect(view.frame));
    if (view.frame.size.width == 0) {
        CGFloat superView_X = superView.frame.origin.x;
        CGFloat view_X = view.frame.origin.x;
        CGFloat superViewWidth = superView.frame.size.width;
        CGFloat viewWidth = (superViewWidth - (view_X - superView_X)) * 0.7;
        //        view.frame = CGRectMake(view_X, view.frame.origin.y, viewWidth, 20);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(viewWidth, defaultHeight));
        }];
        [superView setNeedsLayout];
        [superView layoutIfNeeded];
//        NSLog(@"%@", NSStringFromCGRect(view.frame));
        return YES;
    }
    return NO;
}
- (CABasicAnimation *)scaleXAnimationWithScale_X:(CGFloat)scale_X {
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    anim.removedOnCompletion = NO;        // 保证从前台进入后台仍能执行
    anim.duration = 0.4;
    anim.autoreverses = YES;              // 往返都有动画
    anim.repeatCount = MAXFLOAT;          // 执行次数
    
    anim.toValue = @(0.4 + scale_X);
    
    return anim;
}
- (void)removeSubLayers:(NSArray *)subLayers {
    
    NSArray<CALayer *> *removedLayers = [subLayers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        if ([evaluatedObject isKindOfClass:[CALayer class]]) {
            // remove CAlayers by name
            CALayer *layer = (CALayer *)evaluatedObject;
            if ([layer.name isEqualToString:@"TABLayer"]) {
                return YES;
            }
            return NO;
        }
        return NO;
    }]];
    
    [removedLayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
}
@end
