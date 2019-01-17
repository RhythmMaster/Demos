//
//  TZLGIFPlayViewController.m
//  Demos
//
//  Created by tang on 2018/11/30.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import "TZLGIFPlayViewController.h"
#import <WebKit/WebKit.h>
#import <ImageIO/ImageIO.h>

@interface TZLGIFPlayViewController ()

@end

@implementation TZLGIFPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.index == 0) {
        [self webViewGIF];
    }
    if (self.index == 1) {
        [self imageIOGIF];
    }
}

- (void)webViewGIF {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"企鹅滑" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
 
    WKWebViewConfiguration*config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityCharacter;
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 100, 200, 200) configuration:config];
    [self.view addSubview:wkWebView];
    if (@available(iOS 9.0, *)) {
        [wkWebView loadData:gifData MIMEType:@"image/gif" characterEncodingName:@"" baseURL:@"".tzl_URL];
    } else {
        // Fallback on earlier versions
    }
    config = nil;
}
- (void)dealloc {
    
}

- (void)imageIOGIF {//性能比webview好,且没有内存泄漏
    //gif URL路径
    NSURL *gifURL = [[NSBundle mainBundle] URLForResource:@"企鹅滑" withExtension:@"gif"];
    
    //gif转图片
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)gifURL, NULL);
    
    //图片个数
    size_t frameCount = CGImageSourceGetCount(gifSource);
    
    //将CGImage转化为UIImage，并存储在数组里面
    NSMutableArray *frameArrM = [NSMutableArray array];
    for (size_t i = 0; i < frameCount; i ++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [frameArrM addObject:image];
        CGImageRelease(imageRef);
    }
    
    //动画显示
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
    [self.view addSubview:imageView];
    imageView.animationImages = [frameArrM copy];
    imageView.animationDuration = 1/10;
    [imageView startAnimating];
    
}
@end
