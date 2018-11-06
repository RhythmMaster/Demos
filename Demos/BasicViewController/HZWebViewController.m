//
//  HZWebViewController.m
//  BasicProject
//
//  Created by tang on 2018/3/9.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "HZWebViewController.h"
#import <WebKit/WebKit.h>

@interface HZWebViewController () <WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate>
@property(nonatomic) NSString *url;
@property(nonatomic) WKWebView *webView;
@property(nonatomic, strong) UIProgressView *progressView;
@end

@implementation HZWebViewController
- (instancetype)initWithURL:(NSString *)url title:(NSString *)title {
    if (self = [super init]) {
        self.url = url;
        self.title = title;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self webView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] createBarItemWithImageName:@"1" name:@"隐藏广告" target:self action:@selector(itemAction)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)itemAction {
    NSString *jsStr = @"document.getElementsByTagName('img')[0].style.display='none'";
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
        NSLog(@"-------error: %@",error);
    }];
    jsStr = @"document.getElementsByTagName('img')[1].style.display='none'";
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
        NSLog(@"-------error: %@",error);
    }];
    jsStr = @"document.getElementsByTagName('img')[2].style.display='none'";
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
        NSLog(@"-------error: %@",error);
    }];
    jsStr = @"document.getElementsByTagName('img')[3].style.display='none'";
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
        NSLog(@"-------error: %@",error);
    }];
    jsStr = @"document.getElementsByTagName('img')[4].style.display='none'";
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
        NSLog(@"-------error: %@",error);
    }];
    jsStr = @"document.getElementsByTagName('img')[5].style.display='none'";
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
        NSLog(@"-------error: %@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark delete
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    [SVProgressHUD dismiss];
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
//    [SVProgressHUD dismiss];
}

//加载完成
- (void):(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    //self.progressView.hidden = YES;
    [webView evaluateJavaScript:@"document.getElementsByTagName('header')[0].style.display = 'none'" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    }];
    
    [webView evaluateJavaScript:@"document.documentElement.innerHTML" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"JSError:%@",error);
        }
        NSLog(@"html:\n%@\n",response);
        [self removeADByHTMLSource:response];
    }];
    [self performSelector:@selector(itemAction) afterDelay:3];
    

}
/**
 隐藏网页中的广告
 
 @param HTMLSource 网页html源码串
 */
- (void)removeADByHTMLSource:(NSString *)HTMLSource {
    NSString *fromString = @"javascript:document.getElementById";
    NSString *toString = @".style.display='none'";
    NSArray *strArr = [HTMLSource componentsSeparatedFromString:fromString toString:toString];// (这个截取的头和尾自己看着截,自己怎么觉得方便怎么来)
//    MyLog(@"%@====%@",strArr,strArr.firstObject);
    if (strArr.count) {
        NSString *removeAD_JS_Str = [NSString stringWithFormat:@"%@%@%@",fromString,strArr.firstObject,toString];//再拼接上
        [self.webView evaluateJavaScript:removeAD_JS_Str completionHandler:nil];//执行隐藏广告的JS
    }
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败,%@", error.localizedDescription);
    //加载失败同样需要隐藏progressView
    //self.progressView.hidden = YES;
}


#pragma mark method obver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.tag = 1010110;
        _webView.scrollView.delegate = self;
        ///fineArts/fineArts.html
        NSString *url = [NSString stringWithFormat:@"https://www.tianyancha.com/search/os1-la1-ot1/p2?base=wlmq"];
        if ([self.url hasPrefix:@"http://"] || [self.url hasPrefix:@"https://"]) {
            url = self.url;
        }
        NSLog(@"url-----%@", url);
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        [self.view addSubview:_webView];
        //_webView.frame = self.view.frame;
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 2)];
        _progressView.backgroundColor = [UIColor blueColor];
        //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的2倍.
        _progressView.transform = CGAffineTransformMakeScale(1.0f, 3.0f);
        [self.view addSubview:_progressView];
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _progressView;
}

@end
