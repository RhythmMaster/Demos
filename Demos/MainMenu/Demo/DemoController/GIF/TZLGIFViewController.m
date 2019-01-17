//
//  TZLGIFViewController.m
//  Demos
//
//  Created by tang on 2018/11/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLGIFViewController.h"

@interface TZLGIFViewController ()
@property (nonatomic, strong) NSArray <UIImage *> *imageArr;
/**  */
@property(nonatomic, strong) NSTimer *timer;
/**  */
@property(nonatomic, strong) UIImageView *coverImageView;
@end

@implementation TZLGIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArr = [self loadGifImageArr];
    
    [self setupUI];
}

#pragma mark - Object Private Function

- (void)setupUI {
    UIImageView *coverImageView = [[UIImageView alloc] init];
    coverImageView.layer.borderColor = [UIColor blueColor].CGColor;
    coverImageView.layer.borderWidth = 1.0;
    coverImageView.clipsToBounds = YES;
    coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    coverImageView.frame = CGRectMake(30.0, 100.0, 200, 200);
    [self.view addSubview:coverImageView];
    self.coverImageView = coverImageView;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
- (void)changeImage {
    static NSInteger index = 0;
    if (index < self.imageArr.count) {
        self.coverImageView.image = self.imageArr[index];
        index++;
    } else {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (NSArray *)loadGifImageArr {
    //内存暴增 暂时不知道怎么解决,看起来不是个好办法
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"gif" withExtension:@"gif"];
    
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    size_t gifCount = CGImageSourceGetCount(gifSource);
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    for (size_t i = 0; i< gifCount; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [frames addObject:image];
        CGImageRelease(imageRef);
    }
    return frames;
}

@end
