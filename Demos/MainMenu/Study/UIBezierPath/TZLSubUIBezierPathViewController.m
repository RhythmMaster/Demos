//
//  TZLSubUIBezierPathViewController.m
//  Demos
//
//  Created by tang on 2018/9/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLSubUIBezierPathViewController.h"

@interface TZLSubUIBezierPathViewController ()
/**  */
@property(nonatomic, strong) TZLUIBezierPathView *pathView;
/**  */
@property(nonatomic, strong) UISlider *slider;
/**  */
@property(nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation TZLSubUIBezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.pathMode == UIBezierPathWithDrawRectMode) {
        [self createPathWithDrawRect];
    } else {
        [self createPathWithLayer];
    }
}
//在drawRect:(CGRect)rect中
- (void)createPathWithDrawRect {
    TZLUIBezierPathView *pathView = [[TZLUIBezierPathView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 300) pathStyle:self.pathStyle];
    self.pathView = pathView;
    [self.view addSubview:pathView];
    if (self.pathStyle == UIDrawRectOfDownLoadStyle) {
        [self slider];
    }
}
//配合CAShapeLayer
- (void)createPathWithLayer {
    if (self.pathStyle == UIBezierPathOfCircleStyle) {
        [self UIBezierPathOfCircleStyle];
    }
    if (self.pathStyle == UIBezierPathOfOvalStyle) {
        [self UIBezierPathOfOvalStyle];
    }
    if (self.pathStyle == UIDrawRectOfDownLoadStyle) {
        [self UIDrawRectOfDownLoadStyle];
        self.slider.value = 0.1;
    }
    if (self.pathStyle == UIDrawRectOfSliderStyle) {
        [self UIDrawRectOfSliderStyle];
        self.slider.value = 0.1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method Layer private
- (void)UIBezierPathOfCircleStyle {
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.bounds = CGRectMake(0, 0, 100, 100);
    circleLayer.position = CGPointMake(self.view.width * 0.5, self.view.height * 0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    circleLayer.path = path.CGPath;
    circleLayer.lineWidth = 5;
    circleLayer.lineCap = @"round";
    circleLayer.strokeColor = [UIColor blueColor].CGColor;
    circleLayer.fillColor = [UIColor greenColor].CGColor;
    circleLayer.strokeEnd = 0.75;
    [self.view.layer addSublayer:circleLayer];
}
- (void)UIBezierPathOfOvalStyle {
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.bounds = CGRectMake(0, 0, 100, 100);
    circleLayer.position = CGPointMake(self.view.width * 0.5, self.view.height * 0.5);
    circleLayer.fillColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    UIBezierPath *roundedRectpath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) cornerRadius:5];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 80, 80)];
    UIBezierPath *interPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:35 startAngle:-M_PI_2 endAngle:-M_PI_4  clockwise:YES];
    [interPath addLineToPoint:CGPointMake(50, 50)];
    //合体
    [roundedRectpath appendPath:circlePath];
    [roundedRectpath appendPath:interPath];
    circleLayer.path = roundedRectpath.CGPath;
    circleLayer.fillRule = kCAFillRuleEvenOdd;  //重点， 填充规则
    [self.view.layer addSublayer:circleLayer];
}
- (void)UIDrawRectOfDownLoadStyle {
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    backLayer.bounds = CGRectMake(0, 0, 100, 100);
    backLayer.position = CGPointMake(self.view.width * 0.5, self.view.height * 0.5);
    UIBezierPath *backPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    backLayer.path = backPath.CGPath;
    backLayer.lineCap = @"round";
    backLayer.lineWidth = 6;
    backLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    backLayer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:backLayer];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    self.progressLayer = layer;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(self.view.width * 0.5, self.view.height * 0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:50 startAngle:-M_PI_2 endAngle:M_PI * 1.5 clockwise:YES];
    layer.path = path.CGPath;
    layer.lineCap = @"round";
    layer.lineWidth = 6;
    layer.strokeColor = [UIColor greenColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeEnd = 0.1;
    [self.view.layer addSublayer:layer];
}
- (void)UIDrawRectOfSliderStyle {
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    backLayer.bounds = CGRectMake(0, 0, 150, 20);
    backLayer.position = CGPointMake(self.view.width * 0.5, self.view.height * 0.5);
    backLayer.lineCap = @"round";
    backLayer.lineWidth = 6;
    //strokeColor fillColor需要配合UIBezierPath使用 才能渲染
//    backLayer.strokeColor = [UIColor clearColor].CGColor;
//    backLayer.fillColor = [UIColor lightGrayColor].CGColor;
    backLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.view.layer addSublayer:backLayer];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    self.progressLayer = layer;
    layer.frame = CGRectMake(0, 0, 150 * 0.1, 20);
//    layer.position = CGPointMake(self.view.width * 0.5, self.view.height * 0.5);
    layer.lineCap = @"round";
    layer.lineWidth = 6;
    layer.backgroundColor = [UIColor greenColor].CGColor;
//    layer.strokeColor = [UIColor clearColor].CGColor;
//    layer.fillColor = [UIColor greenColor].CGColor;
    //strokeEnd 这个也必须UIBezierPath渲染使用
    layer.strokeEnd = 0.1;
    [backLayer addSublayer:layer];
}

#pragma  mark lazy
- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(100, self.view.height - 250, 300, 30)];
        [self.view addSubview:_slider];
        [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}
- (void)sliderAction:(UISlider *)sender {
    if (self.pathView) {
        self.pathView.progress = sender.value;
    } else {
        if (self.pathStyle == UIDrawRectOfSliderStyle) {
            self.progressLayer.frame = CGRectMake(0, 0, 150 * sender.value, 20);
        } else {
            self.progressLayer.strokeEnd = sender.value;
        }
    }
    
}
@end


