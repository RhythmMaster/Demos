//
//  TZLEmitterColorViewController.m
//  Demos
//
//  Created by tang on 2018/9/20.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLEmitterColorViewController.h"

@interface TZLEmitterColorViewController ()

@property(nonatomic, strong) CAEmitterLayer *colorLayer;
@end

@implementation TZLEmitterColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupEmitter];
}

- (void)setupEmitter {
    CAEmitterLayer *colorLayer = [CAEmitterLayer layer];
    self.colorLayer = colorLayer;
    [self.view.layer addSublayer:colorLayer];
    colorLayer.emitterPosition = CGPointMake(self.view.width * 0.5, 200);
    colorLayer.emitterSize = CGSizeMake(self.view.width, 0);
    colorLayer.emitterShape = kCAEmitterLayerPoint;
    colorLayer.emitterMode = kCAEmitterLayerPoints;
    
    CAEmitterCell *colorCell = [CAEmitterCell emitterCell];
    colorCell.name = @"colorCell";
    colorCell.contents = (id)[UIImage imageNamed:@"circle_white"].CGImage;
    colorCell.birthRate = 20;
    colorCell.lifetime = 20;
    colorCell.velocity = 40;
    colorCell.velocityRange = 100;
//FIXME:运动方向跟 yAcceleration 和 emissionLongitude有关 yAcceleration是向下加速de
    colorCell.yAcceleration = 20;
    colorCell.emissionLongitude = M_PI;
    colorCell.emissionRange = M_PI_4;
    
    colorCell.scale = 0.2;
    colorCell.scaleRange = 0.1;
    colorCell.scaleSpeed = 0.02;
    
    colorCell.redRange = 1.f;
    colorCell.greenRange = 1.f;
    colorCell.blueSpeed = 1.f;
    colorCell.alphaRange = 0.8;
    colorCell.alphaSpeed = -0.1f;
    
    colorLayer.emitterCells = @[colorCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(point));
    
    self.colorLayer.emitterPosition = point;
    
//    CABasicAnimation * anim = [CABasicAnimation animationWithKeyPath:@"emitterCells.colorCell.scale"];
//    anim.fromValue = @0.2f;
//    anim.toValue = @0.5f;
//    anim.duration = 1.f;
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    [self.colorLayer addAnimation:anim forKey:nil];
//    [self.colorLayer setValue:[NSValue valueWithCGPoint:point] forKeyPath:@"emitterPosition"];
//    [CATransaction commit];
}

@end
