//
//  TZLEmitterRedPackageViewController.m
//  Demos
//
//  Created by tang on 2018/9/20.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLEmitterRedPackageViewController.h"

@interface TZLEmitterRedPackageViewController ()

@end

@implementation TZLEmitterRedPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setEmitter];
    
}
- (void)setEmitter {
    CAEmitterLayer *redPackageLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:redPackageLayer];
    redPackageLayer.emitterShape = kCAEmitterLayerLine;
    redPackageLayer.emitterMode = kCAEmitterLayerOutline;
    redPackageLayer.emitterSize = CGSizeMake(self.view.width, 0);
    redPackageLayer.emitterPosition = CGPointMake(self.view.width * 0.5, self.view.height * 0.5);
    
    CAEmitterCell *redPackageCell = [CAEmitterCell emitterCell];
    redPackageCell.contents = (id)[UIImage imageNamed:@"red_paceket"].CGImage;
    redPackageCell.birthRate = 10;
    redPackageCell.lifetime = 20;
    redPackageCell.velocity = 20;
    redPackageCell.velocityRange = 10;
    redPackageCell.yAcceleration = 100;
    redPackageCell.scale = 0.5;
    
    redPackageLayer.emitterCells = @[redPackageCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
