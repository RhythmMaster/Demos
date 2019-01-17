//
//  TZLCoreAnimationHeightViewController.m
//  Demos
//
//  Created by tang on 2018/12/10.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLCoreAnimationHeightViewController.h"

@interface TZLCoreAnimationHeightViewController ()
/**  */
@property(nonatomic, strong) UIView *secondLayer;
@property(nonatomic, strong) UIView *minuteLayer;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation TZLCoreAnimationHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.index == 0) {
        [self createLayer0];
    }
    if (self.index == 1) {
        [self createLayer1];
    }
    if (self.index == 2) {
        [self createLayer2];
    }
    if (self.index == 3) {
        [self createLayer3];
    }
    if (self.index == 4) {
        [self createLayer4];
    }
}
- (void)createLayer0 {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 150, 300);
    layer.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    UIImage *image = [UIImage imageNamed:@"大乔-吴-步"];
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
}
- (void)createLayer1 {
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(40, 100, 80, 160);
    layer1.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:layer1];
    UIImage *image = [UIImage imageNamed:@"大乔-吴-步"];
    layer1.contents = (__bridge id)image.CGImage;
    layer1.contentsGravity = kCAGravityResizeAspect;
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) ￼toLayer:layer1];
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(150, 100, 80, 160);
    layer2.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:layer2];
    UIImage *image2 = [UIImage imageNamed:@"周姬-吴-弓"];
    layer2.contents = (__bridge id)image2.CGImage;
    layer2.contentsGravity = kCAGravityResizeAspect;
    [self addSpriteImage:image2 withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) ￼toLayer:layer2];
    
    CALayer *layer3 = [CALayer layer];
    layer3.frame = CGRectMake(40, 300, 80, 160);
    layer3.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:layer3];
    UIImage *image3 = [UIImage imageNamed:@"祝融夫人-群-骑"];
    layer3.contents = (__bridge id)image3.CGImage;
    layer3.contentsGravity = kCAGravityResizeAspect;
    [self addSpriteImage:image3 withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) ￼toLayer:layer3];
    
    CALayer *layer4 = [CALayer layer];
    layer4.frame = CGRectMake(150, 300, 80, 160);
    layer4.backgroundColor = [UIColor purpleColor].CGColor;
    [self.view.layer addSublayer:layer4];
    UIImage *image4 = [UIImage imageNamed:@"貂蝉-群-步"];
    layer4.contents = (__bridge id)image4.CGImage;
    layer4.contentsGravity = kCAGravityResizeAspect;
    [self addSpriteImage:image4 withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) ￼toLayer:layer4];
}
- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect ￼toLayer:(CALayer *)layer {//set image
    layer.contents = (__bridge id)image.CGImage;
    
    //scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    
    //set contentsRect
    layer.contentsRect = rect;
}
- (void)createLayer2 {
    UIView *layer = [UIView new];
    layer.frame = CGRectMake(40, 360, 280, 20);
    layer.backgroundColor = [UIColor redColor];
    [self.view addSubview:layer];
    
    UIView *layer1 = [UIView new];
    layer1.frame = CGRectMake(40, 360, 280, 20);
    layer1.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:layer1];
    CGPoint originalPoint = layer1.center;
    layer1.layer.anchorPoint = CGPointMake(0, 0);
    CGPoint newPoint = layer1.center;
    layer1.frame = CGRectMake(40 + newPoint.x - originalPoint.x, 360 + newPoint.y - originalPoint.y, 280, 20);
    self.secondLayer = layer1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [self tick];
}
- (void)tick {
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    //rotate hands
    self.secondLayer.transform = CGAffineTransformMakeRotation(secsAngle);
}
- (void)createLayer3 {
    
    UIView *layer = [UIView new];
    layer.frame = CGRectMake(40, 100, 100, 100);
    layer.backgroundColor = [UIColor greenColor];
    [self.view addSubview:layer];
    self.secondLayer = layer;
    
    UIView *layer1 = [UIView new];
    layer1.frame = CGRectMake(40, 150, 100, 100);
    layer1.backgroundColor = [UIColor redColor];
    [self.view addSubview:layer1];
    
    [self.changeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)changeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.secondLayer.layer.zPosition = 1.0 * sender.selected;
}

- (void)createLayer4 {
    UIView *layer = [UIView new];
    layer.frame = CGRectMake(40, 100, 200, 200);
    layer.backgroundColor = [UIColor greenColor];
    [self.view addSubview:layer];
    self.minuteLayer = layer;
    
    UIView *layer1 = [UIView new];
    layer1.frame = CGRectMake(40, 150, 100, 100);
    layer1.backgroundColor = [UIColor redColor];
    layer1.center = layer.center;
    [self.view addSubview:layer1];
    self.secondLayer = layer1;
    
    [self.changeBtn setTitle:@"现在: convertPoint一层层判断" forState:UIControlStateNormal];
    [self.changeBtn setTitle:@"现在: hitTest一步到位" forState:UIControlStateSelected];
    [self.changeBtn addTarget:self action:@selector(changeHitTestAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)changeHitTestAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if (self.changeBtn.selected) {
        UIView *layer = [self.view hitTest:point withEvent:event];
        if (layer == self.secondLayer) {
            NSLog(@"很厉害,你点到了啊!redColor");
        } else if (layer == self.minuteLayer) {
            NSLog(@"很厉害,你点到了啊!greenColor");
        } else {
            NSLog(@"很厉害,你点到了啊!self.view");
        }
    } else {
        point = [self.view convertPoint:point toView:self.minuteLayer];
        if ([self.minuteLayer.layer containsPoint:point]) {
            point = [self.secondLayer convertPoint:point fromView:self.minuteLayer];
            if ([self.secondLayer.layer containsPoint:point]) {
                NSLog(@"很厉害,你点到了啊!redColor");
            } else {
                NSLog(@"很厉害,你点到了啊!greenColor");
            }
        } else {
            NSLog(@"很厉害,你点到了啊!self.view");
        }
    }
}
@end
