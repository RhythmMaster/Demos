//
//  NSObject+NetWorking.m
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/24.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#import "NSObject+NetWorking.h"

@implementation NSObject (NetWorking)

+ (id)GET:(NSString *)path parameters:(NSDictionary *)parameters downloadProgress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionHandler{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/plain", @"application/json", @"text/javascript", nil];
    return [manager GET:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //打印请求的路径，用于调试  上架时，一定要删了，防止别人偷链接地址
        
        !completionHandler ?: completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //打印请求的路径，用于调试  上架时，一定要删了，防止别人偷链接地址
        
        if (error) {
//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kAppdelegate.window animated:YES];
//            //hud.label.text = @"当前没有网络!";
//            hud.labelText = @"当前没有网络!";
//            //提示框风格
//            hud.mode = MBProgressHUDModeText;
//            //提示1.5秒钟
//            [hud hide:YES afterDelay:1.5];
//            //[hud hideAnimated:YES afterDelay:1.5];
        }
        !completionHandler ?: completionHandler(nil, error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters downloadProgress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    /**
     经测试,如果使用如下的写法拼接会导致地址缺失,post请求不成功
     AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:kBasePath.tzl_URL];
     
     */
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/plain", @"application/json", @"text/javascript", nil];
    return [manager POST:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", task.originalRequest);
        !completionHandler ?: completionHandler(responseObject, nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            /**
             
             出现错误原因之一:服务器传来null, 切记  2017-01-06
             
             */

//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kAppdelegate.window animated:YES];
//            //hud.label.text = @"当前没有网络!";
//            hud.labelText = @"当前没有网络!";
//            //提示框风格
//            hud.mode = MBProgressHUDModeText;
//            //提示1.5秒钟
//            [hud hide:YES afterDelay:1.5];
//            //[hud hideAnimated:YES afterDelay:1.5];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请重新登录" message:@"您已掉线或网络异常" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新登录", nil];
            [alertView show];
#pragma clang diagnostic pop
        }

        !completionHandler ?: completionHandler(nil, error);
    }];
    
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters uploadImage:(UIImage *)uploadImage progress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionHandler {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/plain", @"application/json", @"text/javascript", nil];
    return [manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data;
        if (UIImagePNGRepresentation(uploadImage) == nil) {
            data = UIImageJPEGRepresentation(uploadImage, 1);
        } else {
            data = UIImagePNGRepresentation(uploadImage);
        }
        [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"file.jpg"] mimeType:@"image/png"];
        
        
    } progress:^(NSProgress * progress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            downloadProgress ? downloadProgress(progress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
        !completionHandler ?: completionHandler(responseObject, nil);
        NSLog(@"%@%@", responseObject, [responseObject objectForKey:@"MSG"]);
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            /**
             
             出现错误原因之一:服务器传来null, 切记  2017-01-06
             
             */
            
            NSLog(@"%@", error.localizedDescription);
            
        }
        
        //[kAppdelegate.window showWarning:@"当前没有网络,或网络异常!请检查网络!"];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请重新登录" message:@"您已掉线或网络异常" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新登录", nil];
        [alertView show];
#pragma clang diagnostic pop
        
        !completionHandler ?: completionHandler(nil, error);
    }];
}

+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL fileDir:(NSString *)fileDir progress:(void (^)(NSProgress *))progress success:(void (^)(NSString *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    manager.requestSerializer.timeoutInterval = 30.f;
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    NSURLSessionDownloadTask *downloadTask;
    downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        PPLog(@"下载进度:%.2f%%",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [NSHomeDirectory() stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        PPLog(@"downloadDir = %@",downloadDir);
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        if(failure && error) {failure(error) ; return ;};
//        success ? success([filePath lastPathComponent] /** NSURL->NSString*/) : nil;
        NSLog(@"%@", error.localizedDescription);
    }];
    [downloadTask resume];
    return  downloadTask;
}
//-Wdeprecated-declarations
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {
//        HZLoginViewController *loginVC = [HZLoginViewController new];
//        kAppdelegate.window.rootViewController = loginVC;
    }
}
#pragma clang diagnostic pop
@end
