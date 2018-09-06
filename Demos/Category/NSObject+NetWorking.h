//
//  NSObject+NetWorking.h
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/24.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//   对AFNetWorking的封装
//

#import <Foundation/Foundation.h>

@interface NSObject (NetWorking)<UIAlertViewDelegate>

/**
 description: GET请求
 @param       path 请求的地址
 @param       parameters 请求的参数,类型NSDictionary
 @param       downloadProgress 下载进度
 @param       completionHandler (block块)请求服务器成功后的回调
 @return      返回网络请求
 */
+ (id)GET:(NSString *)path parameters:(NSDictionary *)parameters downloadProgress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id jsonObj, NSError *error))completionHandler;

/**
 description: POST请求
 @param       path 请求的地址
 @param       parameters 请求的参数,类型NSDictionary
 @param       downloadProgress 下载进度
 @param       completionHandler (block块)请求服务器成功后的回调
 @return      返回网络请求
 */
+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters downloadProgress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id jsonObj, NSError *error))completionHandler;

/**
 description: POST文件上传请求
 @param       path 请求的地址
 @param       parameters 请求的参数,类型NSDictionary
 @param       uploadImage 需要上传的图片
 @param       downloadProgress 下载进度
 @param       completionHandler (block块)请求服务器成功后的回调
 @return      返回网络请求
 */
+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters uploadImage:(UIImage *)uploadImage progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id jsonObj, NSError *error))completionHandler;

/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL fileDir:(NSString *)fileDir progress:(void (^)(NSProgress *downloadProgress))progress success:(void(^)(NSString *filePath))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
