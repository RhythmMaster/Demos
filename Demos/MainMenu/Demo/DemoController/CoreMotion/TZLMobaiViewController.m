//
//  TZLMobaiViewController.m
//  Demos
//
//  Created by tang on 2018/11/29.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLMobaiViewController.h"
#import <CoreMotion/CoreMotion.h>

#define kJJMoBikeBallVCBallWidth        40.0

@interface TZLMobaiViewController ()<UICollisionBehaviorDelegate>
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) NSMutableArray <UIImageView *> *ballImageArrM;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior *collision;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItemBehavior;
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation TZLMobaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)dealloc {
    [self.motionManager stopDeviceMotionUpdates];
    self.motionManager = nil;
}
#pragma mark - Object Private Function

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.backgroundColor = [UIColor lightTextColor];
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    [startButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    self.startButton = startButton;
    
    [self.startButton sizeToFit];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(50.0);
    }];
}

- (void)loadBallData {
    NSInteger numberOfBalls = 30;
    
    self.ballImageArrM = [NSMutableArray arrayWithCapacity:30];
    for (NSInteger i = 0; i < numberOfBalls; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        CGFloat redValue = arc4random_uniform(255);
        CGFloat greenValue = arc4random_uniform(255);
        CGFloat blueValue = arc4random_uniform(255);
        imageView.backgroundColor = [UIColor colorWithRed:redValue/255.0 green:greenValue/255.0 blue:blueValue/255.0 alpha:1.0];
        
        CGFloat width = kJJMoBikeBallVCBallWidth;
        imageView.layer.cornerRadius = kJJMoBikeBallVCBallWidth * 0.5;
        imageView.layer.masksToBounds = YES;
        
        imageView.frame = CGRectMake(arc4random()%((int)(self.view.bounds.size.width - width)), 0, width, width);
        [self.view addSubview:imageView];
        [self.ballImageArrM addObject:imageView];
        
        //设置这些球的碰撞重力等其他特性
        [self setupBallProperty];
    }
}

- (void)setupBallProperty {
    UIDynamicAnimator *animator     = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    self.animator = animator;
    
    //添加重力的动态特性，使其可执行
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:self.ballImageArrM];
    [self.animator addBehavior:gravityBehavior];
    self.gravityBehavior = gravityBehavior;
    
    //添加碰撞的动态特性，使其可执行
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:self.ballImageArrM];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    self.collision = collision;
    
    //弹性
    UIDynamicItemBehavior *dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.ballImageArrM];
    dynamicItemBehavior.allowsRotation = YES;//允许旋转
    dynamicItemBehavior.elasticity = 1;//弹性
    [self.animator addBehavior:dynamicItemBehavior];
    
    //开始配置陀螺仪配置
    [self setupGyroPush];
}

- (void)setupGyroPush {
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 1.0/15;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    __weak __typeof(self) weakSelf = self;
    [self.motionManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        NSString *yaw = [NSString stringWithFormat:@"%f",motion.attitude.yaw];
        NSString *pitch = [NSString stringWithFormat:@"%f",motion.attitude.pitch];
        NSString *roll = [NSString stringWithFormat:@"%f",motion.attitude.roll];
        
        double rotation = atan2(motion.attitude.pitch, motion.attitude.roll);
        strongSelf.gravityBehavior.angle = rotation;
    }];
}

#pragma mark - Action && Notification

- (void)startButtonDidClick:(UIButton *)button {
    button.enabled = NO;
    
    //加载球的数据
    [self loadBallData];
}

#pragma mark - <UICollisionBehaviorDelegate>

- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p {
    
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier {
    
}
@end
