//
//  LTNetworkManager.m
//  ios_wisher
//
//  Created by ZhiFan on 2018/9/11.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import "LTNetworkManager.h"
#import <AFNetworking.h>
#import "LTBaseModel.h"


static BOOL isNetworkUse;


@interface LTHTTPClient : AFHTTPSessionManager
+ (instancetype) shareInstance;
@end

@implementation LTHTTPClient

/**
 单例
 @return 对象
 */
+ (instancetype) shareInstance{
    static LTHTTPClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [LTHTTPClient manager];
        
        client.responseSerializer = [AFHTTPResponseSerializer serializer];
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        [client.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        client.requestSerializer.timeoutInterval = 18.0f;
        [client.requestSerializer didChangeValueForKey:@"timeoutInterval"];
/*
//        NSDictionary *info= [[NSBundle mainBundle] infoDictionary];
//
//        NSString *type                = @"type/ios"; // 系统类型
//        NSString *app_version_code    = [NSString stringWithFormat:@"app_version_code/%@",   info[@"CFBundleShortVersionString"]]; // app版本号
//        NSString *app_version_name    = [NSString stringWithFormat:@"app_version_name/%@",   info[@"CFBundleVersion"]]; // app版本名
//        NSString *phone_brand         = [NSString stringWithFormat:@"phone_brand/%@",         @"Apple"]; // 手机品牌
//        NSString *phone_model         = [NSString stringWithFormat:@"phone_model/%@",         [LTGetCurrentVC lt_iphoneModel]]; // 手机型号
//        NSString *system_version_code = [NSString stringWithFormat:@"system_version_code/%@",[[UIDevice currentDevice] systemVersion]]; // 系统版本号
//        NSString *system_version_name = [NSString stringWithFormat:@"system_version_name/%@",[[UIDevice currentDevice] systemName]]; // 系统版本名
//        NSString *UserAgent = [NSString stringWithFormat:@"%@;%@;%@;%@;%@;%@;%@",type,app_version_code,app_version_name,phone_brand,phone_model,system_version_code,system_version_name];
//        [client.requestSerializer setValue:UserAgent forHTTPHeaderField:@"User-Agent"];
 */
    });
    return client;
}

@end

@implementation LTNetworkManager
+ (void)httpRequest:(NetRequestType)type
                 url:(NSString *)url
                para:(NSDictionary *)para
             success:(SuccessBlock)success
             failure:(FailureBlock)failure{
    if (type == RequestTypeGET) {
        [[LTHTTPClient shareInstance] GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }else{
        [[LTHTTPClient shareInstance] POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }
}
/**
 *  下载文件
 *
 *  @param path     url路径
 *  @param success  下载成功
 *  @param failure  下载失败
 *  @param progress 下载进度
 */
+ (void)downloadWithPath:(NSString *)path
                 success:(SuccessBlock)success
                 failure:(FailureBlock)failure
                progress:(DownloadProgressBlock)progress{
    //获取完整的url路径
    NSString * urlString = [prefixUrl stringByAppendingPathComponent:path];
    //下载
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [[LTHTTPClient shareInstance] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress.fractionCompleted);
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        //获取沙盒cache路径
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
    }];
    [downloadTask resume];
}
/**
 *  上传图片
 *
 *  @param path     url地址
 *  @param images    UIImage对象数组
 *  @param imagekey    imagekey
 *  @param params  上传参数
 *  @param success  上传成功
 *  @param failure  上传失败
 *  @param progress 上传进度
 */

+ (void)uploadImageWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)imagekey
                     images:(NSArray *)images
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure
                   progress:(UploadProgressBlock)progress {
    
    [[LTHTTPClient shareInstance] POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in images) {
            NSData *data = UIImageJPEGRepresentation(image,0.5);
            [formData appendPartWithFileData:data
                                        name:@"file"
                                    fileName:imagekey
                                    mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

/**
 获取网络状态是否可用
 @param returnStatus 回调网络是否可用
 */
- (void) checkNetworkStatus:(void(^)(BOOL netUsable))returnStatus{
    [self getNetorkStatus:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusNotReachable){
            // 网络异常操作
            isNetworkUse = NO;
        }
        // 更新网络相关状态属性
        self.netStatus = status;
        self.isNetUsable = isNetworkUse;
        
        returnStatus(isNetworkUse);
    }];
}


/**
 获取实际的网络状态
 @param resultBack 回调实际的网络状态
 */
- (void) getNetorkStatus:(void(^)(AFNetworkReachabilityStatus status))resultBack{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        resultBack(status);
        [[NSNotificationCenter defaultCenter] postNotificationName:NetStatusChange object:nil];
    }];
}

/**
 结束网络监听
 */
- (void)stopChetNet{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}


+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    static LTNetworkManager *shareManager = nil;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}



@end
