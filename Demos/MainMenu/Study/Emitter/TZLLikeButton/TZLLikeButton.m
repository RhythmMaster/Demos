//
//  TZLLikeButton.m
//  Demos
//
//  Created by tang on 2018/9/21.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLLikeButton.h"
@interface TZLLikeButton()
/**  */
@property(nonatomic, strong) CAEmitterLayer *explosionLayer;
@end
@implementation TZLLikeButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setupExplosion];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupExplosion];
    }
    return self;
}

- (void)setupExplosion{
    CAEmitterLayer *explosionLayer = [CAEmitterLayer layer];
    explosionLayer.emitterShape = kCAEmitterLayerCircle;
    explosionLayer.emitterMode = kCAEmitterLayerOutline;
    explosionLayer.birthRate = 0;
    self.explosionLayer = explosionLayer;
    self.explosionLayer.emitterSize = CGSizeMake(self.bounds.size.width + 40, self.bounds.size.height + 40);
    [self.layer addSublayer:explosionLayer];
    
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.birthRate = 1000;
    explosionCell.lifetime = 1;
    explosionCell.velocity = 40;
    explosionCell.velocityRange = 10;
    explosionCell.scale = 0.08;
    explosionCell.scaleRange = 0.02;
    explosionCell.alphaSpeed = -1.f;
    explosionCell.alphaRange = 0.10;
    explosionCell.lifetimeRange = 0.1;
    explosionCell.contents = (id)[[UIImage imageNamed:@"spark_red"] CGImage];
    explosionLayer.emitterCells = @[explosionCell];
}
- (void)layoutSubviews {
    
    
    self.explosionLayer.emitterPosition = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    if (selected) {
        animation.values = @[@1.5, @2.0, @0.8, @1.0];
        animation.duration = 0.25;
        animation.calculationMode = kCAAnimationCubic;
        [self.layer addAnimation:animation forKey:nil];
        [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.25];
    }
}
- (void)startAnimation{
    self.explosionLayer.birthRate = 1;
     [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
}
- (void)stopAnimation{
    // 用KVC设置颗粒个数
    self.explosionLayer.birthRate = 0;
}
@end
