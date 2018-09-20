//
//  TZLEmitterSnowViewController.m
//  Demos
//
//  Created by tang on 2018/9/20.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLEmitterSnowViewController.h"

@interface TZLEmitterSnowViewController ()
@property (nonatomic, weak) UIImageView * imageView;
@end

@implementation TZLEmitterSnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    UIImageView *backImageView = [UIImageView new];
    self.imageView = backImageView;
    [self.view addSubview:backImageView];
    backImageView.frame = self.view.frame;
    backImageView.image = [UIImage imageNamed:@"tree"];
    
    CAEmitterLayer *snowLayer = [CAEmitterLayer layer];
    [backImageView.layer addSublayer:snowLayer];
    snowLayer.emitterShape = kCAEmitterLayerLine;
    snowLayer.emitterMode = kCAEmitterLayerSurface;
    snowLayer.emitterPosition = CGPointMake(self.view.width * 0.5, -10);
    snowLayer.emitterSize = CGSizeMake(self.view.width, self.view.height);
    
    CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
    snowCell.contents = (id)[UIImage imageNamed:@"snow_white"].CGImage;
    snowCell.birthRate = 10;
    snowCell.velocity = 10;
    snowCell.velocityRange = 2;
    snowCell.lifetime = 200;
    snowCell.scale = 0.2;
    snowCell.scaleRange = 0.1;
    snowCell.yAcceleration = 2;
    
    snowCell.emissionLongitude = M_PI_2 + M_PI_2; // 向下
    snowCell.emissionRange = M_PI_4; // 向下
    
    snowLayer.emitterCells = @[snowCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
