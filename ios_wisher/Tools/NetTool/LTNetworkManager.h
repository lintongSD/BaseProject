//
//  LTNetworkManager.h
//  ios_wisher
//
//  Created by ZhiFan on 2018/9/11.
//  Copyright © 2018年 lin-tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTNetworkManager : NSObject
typedef NS_ENUM(NSInteger, NetRequestType) {
    RequestTypeGET,
    RequestTypePOST,
};
//成功
typedef void(^SuccessBlock)(id resultData);
//失败
typedef void(^FailureBlock)(NSError *error);
//下载进度
typedef void(^DownloadProgressBlock)(CGFloat progress);
//上传进度
typedef void(^UploadProgressBlock)(CGFloat progress);


//**  网络是否可用 */
@property (nonatomic, assign) BOOL isNetUsable;
//**  网络实际状态 */
@property (nonatomic, assign) AFNetworkReachabilityStatus netStatus;


+ (instancetype)shareManager;

+ (void)httpRequest:(NetRequestType)type
                url:(NSString *)url
               para:(NSDictionary *)para
            success:(SuccessBlock)success
            failure:(FailureBlock)failure;
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
                progress:(DownloadProgressBlock)progress;
/**
 *  上传图片
 *
 *  @param path     url地址
 *  @param images    UIImage对象
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
                   progress:(UploadProgressBlock)progress;

/**
 获取网络状态是否可用
 @param returnStatus 回调网络是否可用
 */
- (void) checkNetworkStatus:(void(^)(BOOL netUsable))returnStatus;
/**
 获取实际的网络状态
 @param resultBack 回调实际的网络状态
 */
- (void) getNetorkStatus:(void(^)(AFNetworkReachabilityStatus status))resultBack;

/**
 结束网络监听
 */
- (void)stopChetNet;

@end
