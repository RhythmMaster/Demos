//
//  TZLEmitterRainViewController.m
//  Demos
//
//  Created by tang on 2018/9/20.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLEmitterRainViewController.h"

@interface TZLEmitterRainViewController ()
@property (nonatomic, strong) CAEmitterLayer * rainLayer;
@property (nonatomic, weak) UIImageView * imageView;
@end

@implementation TZLEmitterRainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupEmitter];
}

- (void)setupUI {
    UIImageView *backImageView = [UIImageView new];
    self.imageView = backImageView;
    [self.view addSubview:backImageView];
    backImageView.frame = self.view.frame;
    backImageView.image = [UIImage imageNamed:@"tree"];
    
    // 下雨按钮
    UIButton * startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:startBtn];
    startBtn.frame = CGRectMake(20, self.view.bounds.size.height - 60, 80, 40);
    startBtn.backgroundColor = [UIColor whiteColor];
    [startBtn setTitle:@"雨停了" forState:UIControlStateNormal];
    [startBtn setTitle:@"下雨" forState:UIControlStateSelected];
    [startBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [startBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 雨量按钮
    UIButton * rainBIgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:rainBIgBtn];
    rainBIgBtn.tag = 100;
    rainBIgBtn.frame = CGRectMake(140, self.view.bounds.size.height - 60, 80, 40);
    rainBIgBtn.backgroundColor = [UIColor whiteColor];
    [rainBIgBtn setTitle:@"下大点" forState:UIControlStateNormal];
    [rainBIgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rainBIgBtn addTarget:self action:@selector(rainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rainSmallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:rainSmallBtn];
    rainSmallBtn.tag = 200;
    rainSmallBtn.frame = CGRectMake(240, self.view.bounds.size.height - 60, 80, 40);
    rainSmallBtn.backgroundColor = [UIColor whiteColor];
    [rainSmallBtn setTitle:@"太大了" forState:UIControlStateNormal];
    [rainSmallBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rainSmallBtn addTarget:self action:@selector(rainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setupEmitter {
    CAEmitterLayer *rainLayer = [CAEmitterLayer layer];
    [self.imageView.layer addSublayer:rainLayer];
    self.rainLayer = rainLayer;
    rainLayer.emitterShape = kCAEmitterLayerLine;
    rainLayer.emitterMode = kCAEmitterLayerSurface;
    rainLayer.emitterSize = CGSizeMake(self.view.frame.size.width, 0);
    rainLayer.emitterPosition = CGPointMake(self.view.width * 0.5, -10);
    
    CAEmitterCell *rainCell = [CAEmitterCell emitterCell];
    rainCell.contents = (id)[UIImage imageNamed:@"rain_white"].CGImage;
    rainCell.scale = 0.2;
    rainCell.scaleRange = 0.05;
    rainCell.birthRate = 10;//每秒钟产生多少个粒子
    rainCell.lifetime = 20;//粒子存在时间
    rainCell.speed = 10;//粒子产生的速度  配合birthRate 就相当于 1秒钟 产生 10*10个粒子
    rainCell.velocity = 10;//粒子初始发射速度
    rainCell.velocityRange = 10;
    rainCell.yAcceleration = 1000;
    
    rainLayer.emitterCells = @[rainCell];
    
}

- (void)buttonClick:(UIButton *)sender{
    
    if (!sender.selected) {
        
        sender.selected = !sender.selected;
        NSLog(@"雨停了");
        
        // 停止下雨
        [self.rainLayer setValue:@0.f forKeyPath:@"birthRate"];
        
    }else{
        
        sender.selected = !sender.selected;
        NSLog(@"开始下雨了");
        
        // 开始下雨
        [self.rainLayer setValue:@1.f forKeyPath:@"birthRate"];
    }
}

- (void)rainButtonClick:(UIButton *)sender{
    
    NSInteger rate = 1;
    CGFloat scale = 0.1;
    if (sender.tag == 100) {
        
        NSLog(@"下大了");
        
        if (self.rainLayer.birthRate < 30) {
            [self.rainLayer setValue:@(self.rainLayer.birthRate + rate) forKeyPath:@"birthRate"];
            [self.rainLayer setValue:@(self.rainLayer.scale + scale) forKeyPath:@"scale"];
        }
        
    }else if (sender.tag == 200){
        
        NSLog(@"变小了");
        
        if (self.rainLayer.birthRate > 1) {
            [self.rainLayer setValue:@(self.rainLayer.birthRate - rate) forKeyPath:@"birthRate"];
            [self.rainLayer setValue:@(self.rainLayer.scale - scale) forKeyPath:@"scale"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end
