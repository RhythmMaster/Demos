//
//  TZLMBProgressHUDViewController.m
//  Demos
//
//  Created by tang on 2018/11/28.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLMBProgressHUDViewController.h"

@interface TZLMBProgressHUDViewController ()

@end

@implementation TZLMBProgressHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.index == 0) {
        [self loadingViewOne];
    }
    if (self.index == 1) {
        [self loadingViewTwo];
    }
    if (self.index == 2) {
        [self loadingViewThree];
    }
    if (self.index == 3) {
        [self loadingViewFour];
    }
    if (self.index == 4) {
        [self loadingViewFive];
    }
    if (self.index == 5) {
        [self loadingViewSix];
    }
    if (self.index == 6) {
        [self loadingViewSeven];
    }
}

- (void)loadingViewOne {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        hud.mode = MBProgressHUDModeIndeterminate;
        [self.view addSubview:hud];
        [hud show:YES];
        [hud hide:YES afterDelay:3];
    });
}

- (void)loadingViewTwo {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        hud.mode = MBProgressHUDModeDeterminate;
        [self.view addSubview:hud];
        [hud show:YES];
        
        __block CGFloat num = 0;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (NSInteger i = 1; i <= 10; i++) {
                sleep(1);
                num = i / 10.0;
                NSLog(@"%@---%f", [NSThread currentThread], num);
                dispatch_async(dispatch_get_main_queue(), ^{
                    hud.progress = num;
                    if (num >= 1) {
                        [hud hide:YES afterDelay:3];
                    }
                });
            }
        });
    });
}

- (void)loadingViewThree {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
        [self.view addSubview:hud];
        [hud show:YES];
        
        __block CGFloat num = 0;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (NSInteger i = 1; i <= 10; i++) {
                sleep(1);
                num = i / 10.0;
                NSLog(@"%@---%f", [NSThread currentThread], num);
                dispatch_async(dispatch_get_main_queue(), ^{
                    hud.progress = num;
                    hud.labelText = [NSString stringWithFormat:@"进度:%.2f%%", num * 100];
                    if (num >= 1) {
                        [hud hide:YES afterDelay:3];
                    }
                });
            }
        });
    });
}

- (void)loadingViewFour {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
//        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.labelColor = [UIColor whiteColor];
        //设置进度条的的边线和进度的颜色
//        hud.contentColor = [UIColor whiteColor];
        hud.labelText = @"正在加载";
        [self.view addSubview:hud];
        [hud show:YES];
        
        __block CGFloat num = 0;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (NSInteger i = 1; i <= 10; i++) {
                sleep(1);
                num = i / 10.0;
                NSLog(@"%@---%f", [NSThread currentThread], num);
                dispatch_async(dispatch_get_main_queue(), ^{
                    hud.progress = num;
                    if (num >= 1) {
                        [hud hide:YES afterDelay:3];
                    }
                });
            }
        });
    });
}
- (void)loadingViewFive {
    
    //自定义视图的样式
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"大乔-吴-步"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = imageView;
        [self.view addSubview:hud];
        [hud show:YES];
        [hud hide:YES afterDelay:3];
    });
}
- (void)loadingViewSix {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"全球化";
        hud.detailsLabelText = @"我们一起参与";
        [self.view addSubview:hud];
        [hud show:YES];
        [hud hide:YES afterDelay:3];
    });
}
- (void)loadingViewSeven {
    //自定义视图的样式
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"大乔-吴-步"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = imageView;
        hud.labelText = @"全球化";
        hud.detailsLabelText = @"我们一起参与";
        [self.view addSubview:hud];
        [hud show:YES];
        [hud hide:YES afterDelay:3];
    });
}
@end
