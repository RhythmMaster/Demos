//
//  TZLNetImageViewController.m
//  Demos
//
//  Created by tang on 2019/1/7.
//  Copyright © 2019年 TZL. All rights reserved.
//

#import "TZLNetImageViewController.h"
#import <UIImage+GIF.h>

@interface TZLNetImageViewController ()<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
@property (nonatomic) NSMutableData * data;
@property (nonatomic)NSUInteger expectlength;
/**  */
@property(nonatomic, strong) UIImageView *netImage;
/**  */
@property(nonatomic, strong) UIProgressView *progressView;
@property (strong,nonatomic)NSURLSessionTask * task;
@end

@implementation TZLNetImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:@"https://upfile.asqql.com/2009pasdfasdfic2009s305985-ts/2018-4/2018423202071807.gif".tzl_URL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    self.task = task;
    
    
    UIImageView *netImage = [UIImageView new];
    [self.view addSubview:netImage];
    [netImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(110);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(200);
    }];
    self.netImage = netImage;
    
    UIProgressView *progressView = [[UIProgressView alloc] init];
    [self.view addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.top.equalTo(100);
        make.height.equalTo(5);
    }];
    progressView.progressTintColor = [UIColor orangeColor];
    self.progressView = progressView;
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.bottom.equalTo(-50);
    }];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *pauseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:pauseBtn];
    [pauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.bottom.equalTo(-50);
    }];
    [pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [pauseBtn addTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-20);
        make.bottom.equalTo(-50);
    }];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)startAction:(UIButton *)sender {
    if (self.task.state == NSURLSessionTaskStateSuspended) {
        [self.task resume];
    }
}
- (void)pauseAction:(UIButton *)sender {
    if (self.task.state == NSURLSessionTaskStateRunning) {
        [self.task suspend];
    }
}
- (void)cancelAction:(UIButton *)sender {
    switch (self.task.state) {
        case NSURLSessionTaskStateRunning:
        case NSURLSessionTaskStateSuspended:
            
            if ([self.task isKindOfClass:[NSURLSessionDownloadTask class]]) {
                [(NSURLSessionDownloadTask *)(self.task) cancelByProducingResumeData:^(NSData *resumeData) {
//                    self.resumeData = resumeData;
                }];
            }else {
                [self.task cancel];
            }
            
            
            break;
        default:
            break;
    }
}
#pragma mark delete -NSURLSessionDelegate
#pragma mark 会话总代理
#pragma mark 通知>>session被关闭
//[session invalidateAndCancel] 直接取消所有任务 或者[session finishTasksAndInvalidate]等待的任务完成后取消 其他的直接取消
//session被关闭时调用、持有的delegate将被清空
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"NSURLSessionDelegate:::通知>>session被关闭");
}

#pragma mark 询问>>服务器客户端配合验证--会话级别
/*
 参考：
 https://www.jianshu.com/p/2642e31919e7
 https://www.2cto.com/kf/201604/504149.html
 https://blog.csdn.net/jingcheng345413/article/details/65437649
 NSURLAuthenticationChallenge 类中最重要的一个属性是protectionSpace。
 该属性是一个 NSURLProtectionSpace 的实例，一个NSURLProtectionSpace对象通过属性host、isProxy、port、protocol、proxyType和realm代表了请求验证的服务器端的范围。
 而NSURLProtectionSpace类的authenticationMethod属性则指明了服务端的验证方式，可能的值包括:
 
 challenge.protectionSpace {
 // 默认
 NSURLAuthenticationMethodDefault
 // 基本的 HTTP 验证，通过 NSURLCredential 对象提供用户名和密码。
 NSURLAuthenticationMethodHTTPBasic
 // 类似于基本的 HTTP 验证，摘要会自动生成，同样通过 NSURLCredential 对象提供用户名和密码。
 NSURLAuthenticationMethodHTTPDigest
 // 不会用于 URL Loading System，在通过 web 表单验证时可能用到。
 NSURLAuthenticationMethodHTMLForm
 
 <<<<<***************>>>>>
 //Negotiate（协商，Kerberos or NTLM）
 NSURLAuthenticationMethodNegotiate
 //NTLM（WindowsNT使用的认证方式
 NSURLAuthenticationMethodNTLM
 // 验证客户端的证书
 NSURLAuthenticationMethodClientCertificate
 // 指明客户端要验证服务端提供的证书
 NSURLAuthenticationMethodServerTrust
 }
 
 其中后四个为会话级别验证
 将会优先调用会话级别验证、如果未实现再调用任务界别验证。
 */

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"NSURLSessionDelegate:::询问>>服务器客户端配合验证--会话级别");
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,nil);
}

#pragma mark 通知>>所有后台下载任务全部完成
//必须在backgroundSessionConfiguration 并且在后台完成时才会调用
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session API_AVAILABLE(ios(7.0), watchos(2.0), tvos(9.0)) API_UNAVAILABLE(macos) {
    NSLog(@"NSURLSessionDelegate:::通知>>所有后台下载任务全部完成");
}

#pragma mark delete NSURLSessionTaskDelegate
#pragma mark 任务总代理

#pragma mark 通知>>延时任务被调用
/*
 当设置了earliestBeginDate属性
 (需要注意这个属性对于非后台任务并不有效、而且不能保证定时执行、只能保证不会在指定日期之前执行)
 的NSURLSessionTask被延迟调用的、会走这里
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willBeginDelayedRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLSessionDelayedRequestDisposition disposition, NSURLRequest * _Nullable newRequest))completionHandler
API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0)) {
    /*
     typedef NS_ENUM(NSInteger, NSURLSessionDelayedRequestDisposition) {
     NSURLSessionDelayedRequestContinueLoading = 0,  //使用原始请求、参数忽略
     NSURLSessionDelayedRequestUseNewRequest = 1,    //使用新请求
     NSURLSessionDelayedRequestCancel = 2,   //取消任务、参数忽略
     }
     */
    completionHandler(NSURLSessionDelayedRequestContinueLoading,request);
    
}

#pragma mark 通知>>网络受限导致任务进入等待
/*
 如果NSURLSessionConfiguration的waitsForConnectivity属性为true
 并且由于网络不通(并不是并发受限)没有被立即发出时
 此方法最多只能在每个任务中调用一次、并且仅在连接最初不可用时调用。
 它永远不会被调用后台会话，因为这些会话会忽略waitsForConnectivity。
 
 */

- (void)URLSession:(NSURLSession *)session taskIsWaitingForConnectivity:(NSURLSessionTask *)task
API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0)) {
    NSLog(@"NSURLSessionTaskDelegate:::通知>>网络受限导致任务进入等待");
}

#pragma mark 准备开始请求、询问是否重定向
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    NSLog(@"NSURLSessionTaskDelegate:::询问>>是否重定向");
    completionHandler(request);
}

#pragma mark 询问>>服务器需要客户端配合验证--任务级别
//除非未实现会话级别对应代理、否则不会调用任务级别验证方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"NSURLSessionTaskDelegate:::询问>>服务器需要客户端配合验证--任务级别");
    NSURLCredential * cre =[NSURLCredential credentialWithUser:@"kirito_song" password:@"psw" persistence:NSURLCredentialPersistenceNone];
    completionHandler(NSURLSessionAuthChallengeUseCredential,cre);
}

#pragma mark 询问>>流任务的方式上传--需要客户端提供数据源
/* 当任务需要新的请求主体流发送到远程服务器时，告诉委托。
 这种委托方法在两种情况下被调用：
 1、如果使用uploadTaskWithStreamedRequest创建任务，则提供初始请求正文流：
 2、如果任务因身份验证质询或其他可恢复的服务器错误需要重新发送包含正文流的请求，则提供替换请求正文流。
 注：如果代码使用文件URL或NSData对象提供请求主体，则不需要实现此功能。
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream * _Nullable bodyStream))completionHandler {
    NSLog(@"NSURLSessionTaskDelegate:::询问>>数据流的方式上传--需要客户端提供数据源");
}

#pragma mark 通知>>上传进度
/* 定期通知代理向服务器发送主体内容的进度。*/
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    NSLog(@"NSURLSessionTaskDelegate:::通知>>上传进度");
}

#pragma mark 通知>>任务信息收集完成
/*
 对发送请求/DNS查询/TLS握手/请求响应等各种环节时间上的统计. 更易于我们检测, 分析我们App的请求缓慢到底是发生在哪个环节, 并对此进行优化提升我们APP的性能.
 
 NSURLSessionTaskMetrics对象与NSURLSessionTask对象一一对应. 每个NSURLSessionTaskMetrics对象内有3个属性 :
 
 taskInterval : task从开始到结束总共用的时间
 redirectCount : task重定向的次数
 transactionMetrics : 一个task从发出请求到收到数据过程中派生出的每个子请求, 它是一个装着许多NSURLSessionTaskTransactionMetrics对象的数组. 每个对象都代表下图的一个子过程
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0)) {
    NSLog(@"NSURLSessionTaskDelegate:::通知>>任务信息收集完成");
    NSLog(@"::::::::::::相关讯息::::::::::::\n总时间:%@\n,重定向次数:%zd\n,派生的子请求:%zd",metrics.taskInterval,metrics.redirectCount,metrics.transactionMetrics.count);
}

#pragma mark 通知>>任务完成
//无论成功、失败或者取消
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"NSURLSessionTaskDelegate:::通知>>任务完成");
    if (!error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.netImage.image = [UIImage sd_animatedGIFWithData:self.data];
        });
        
    }
}

#pragma mark delete NSURLSessionDataDelegate
#pragma mark 数据任务代理
#pragma mark 通知>>服务器返回响应头
#pragma mark 询问>>下一步操作
//服务器返回响应头、询问下一步操作(取消操作、普通传输、下载、数据流传输)
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"NSURLSessionDataDelegate:::通知>>服务器返回响应头。询问>>下一步操作");
    self.expectlength = response.expectedContentLength;
    completionHandler(NSURLSessionResponseAllow);
    //    completionHandler(NSURLSessionResponseBecomeDownload);
    //    completionHandler(NSURLSessionResponseBecomeStream);
}

#pragma mark 通知>>数据任务已更改为下载任务
//你可以通过上面的 completionHandler(NSURLSessionResponseBecomeDownload);进行测试
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    NSLog(@"NSURLSessionDataDelegate:::通知>>数据任务已更改为下载任务");
}

#pragma mark 通知>>数据任务已更改为流任务
//你可以通过上面的 completionHandler(NSURLSessionResponseBecomeStream);进行测试
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask  API_AVAILABLE(ios(9.0)){
    NSLog(@"NSURLSessionDataDelegate:::通知>>数据任务已更改为下载任务");
}

#pragma mark 通知>>服务器成功返回数据
//已经收到了一些(大数据可能多次调用)数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    NSLog(@"NSURLSessionDataDelegate:::通知>>服务器成功返回数据");
    [self.data appendData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = self.data.length / ((float)self.expectlength);
    });
    
}

#pragma mark 询问>>是否把Response存储到Cache中
//任务是否应将响应存储在缓存中
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler {
    NSLog(@"NSURLSessionDataDelegate:::询问>>是否把Response存储到Cache中");
    NSCachedURLResponse * res = [[NSCachedURLResponse alloc]initWithResponse:proposedResponse.response data:proposedResponse.data userInfo:nil storagePolicy:NSURLCacheStorageNotAllowed];
    completionHandler(res);
}

#pragma mark delete NSURLSessionDownloadDelegate
#pragma mark 下载任务代理
#pragma mark 通知>>下载任务已经完成
//location 临时文件的位置url 需要手动移动文件至需要保存的目录
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"NSURLSessionDownloadDelegate:::通知>>下载任务已经完成");
}
#pragma mark 通知>>下载任务进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"NSURLSessionTaskDelegate:::通知>>下载任务进度");
}

//filrOffest 已经下载的文件大小  expectedTotalBytes预期总大小
/*
 你可以通过 [session downloadTaskWithResumeData：resumeData]之类的方法来重新恢复一个下载任务
 resumeData在下载任务失败的时候会通过error.userInfo[NSURLSessionDownloadTaskResumeData]来返回以供保存
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"NSURLSessionTaskDelegate:::通知>>下载任务已经恢复下载");
}


#pragma mark delete NSURLSessionStreamDelegate
#pragma mark 流任务代理
#pragma mark 通知>>数据流的连接中读数据的一边已经关闭
- (void)URLSession:(NSURLSession *)session readClosedForStreamTask:(NSURLSessionStreamTask *)streamTask API_AVAILABLE(ios(9.0)) {
    NSLog(@"NSURLSessionStreamDelegate:::通知>>数据流的连接中读数据的一边已经关闭");
}

#pragma mark 通知>>数据流的连接中写数据的一边已经关闭
- (void)URLSession:(NSURLSession *)session writeClosedForStreamTask:(NSURLSessionStreamTask *)streamTask API_AVAILABLE(ios(9.0)) {
    NSLog(@"NSURLSessionStreamDelegate:::通知>>数据流的连接中写数据的一边已经关闭");
}

#pragma mark 通知>>系统已经发现了一个更好的连接主机的路径
- (void)URLSession:(NSURLSession *)session betterRouteDiscoveredForStreamTask:(NSURLSessionStreamTask *)streamTask  API_AVAILABLE(ios(9.0)){
    NSLog(@"NSURLSessionStreamDelegate:::通知>>系统已经发现了一个更好的连接主机的路径");
}

#pragma mark 通知>>流任务已完成
- (void)URLSession:(NSURLSession *)session streamTask:(NSURLSessionStreamTask *)streamTask
didBecomeInputStream:(NSInputStream *)inputStream
      outputStream:(NSOutputStream *)outputStream API_AVAILABLE(ios(9.0)) {
    NSLog(@"NSURLSessionStreamDelegate:::通知>>流任务已完成");
}


- (NSMutableData *)data {
    if (!_data) {
        _data = [NSMutableData new];
    }
    return _data;
}

@end
