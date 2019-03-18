//
//  YDNetwrokManager.h
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(id responseData, NSURLSessionDataTask *task);
typedef void(^FailureBlock)(NSString *errorString, NSInteger errorCode, NSURLSessionDataTask *task);

NS_ASSUME_NONNULL_BEGIN

@interface YDNetwrokManager : NSObject

+ (YDNetwrokManager *)sharedInstance;

/**
 *  POST 方法
 *
 *  @param urlString  请求的服务端的地址
 *  @param parameters  参数
 *  @param success  请求成功返回
 *  @param failure  请求失败返回
 *
 */
- (void)POST:(NSString *)urlString
  parameters:(id)parameters
     success:(CompletionBlock)success
     failure:(FailureBlock)failure;

/**
 *  GET 方法
 *
 *  @param urlString  请求的服务端的地址
 *  @param parameters  参数
 *  @param success  请求成功返回
 *  @param failure  请求失败返回
 */
- (void)GET:(NSString *)urlString
 parameters:(id)parameters
    success:(CompletionBlock)success
    failure:(FailureBlock)failure;

/**
 *  设置凭证（header）
 *
 *  @param token  token凭证
 */

- (void)setUserToken:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
