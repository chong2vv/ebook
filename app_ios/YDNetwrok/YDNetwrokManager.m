//
//  YDNetwrokManager.m
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDNetwrokManager.h"
#import "YDNetWorkCheckManager.h"
#import "YDUrlMacros.h"

@interface YDNetwrokManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

static NSInteger NETWORK_ERROR = 1000001;

@implementation YDNetwrokManager

+ (YDNetwrokManager *)sharedInstance {
    static dispatch_once_t once;
    static YDNetwrokManager *instance;
    dispatch_once(&once, ^ {
        instance = [[YDNetwrokManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self){
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:YDBaseUrl]];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_sessionManager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];
        [_sessionManager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"device"];
    }
    return self;
}

#pragma mark - POST Method

- (void)POST:(NSString *)urlString parameters:(id)parameters success:(CompletionBlock)success failure:(FailureBlock)failure {
    
    if([[YDNetWorkCheckManager sharedInstance] isNetworkBroken]) {
        if (failure) {
            failure(@"请求失败，请检查网络", NETWORK_ERROR, nil);
        }
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param addEntriesFromDictionary:parameters];
    
    [_sessionManager POST:urlString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject){
            
            NSDictionary *dic=responseObject;
            
            if (dic&&[dic isKindOfClass:[NSDictionary class]]) {
                NSInteger errorCode = [[dic objectForKey:@"code"] integerValue];
                
                if ([[dic objectForKey:@"code"] intValue] == 200) {
                    if (success) {
                        success(dic,task);
                    }else{
                        NSString *errorMsg = [dic objectForKey:@"msg"];
                        
                        failure(errorMsg, errorCode, task);
                    }
                }else{
                    NSString *errorMsg = [dic objectForKey:@"msg"];
                    
                    failure(errorMsg, errorCode, task);
                }
                
            }else{
                if (failure) {
                    failure(@"请求失败,请重试", NETWORK_ERROR, task);
                }
            }
        }else{
            if (failure) {
                failure(@"请求失败,请重试", NETWORK_ERROR, task);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(@"请求失败,请重试", NETWORK_ERROR, task);
        }
    }];
}

#pragma mark - GET Method

- (void)GET:(NSString *)urlString parameters:(id)parameters success:(CompletionBlock)success failure:(FailureBlock)failure {
    
    if([[YDNetWorkCheckManager sharedInstance] isNetworkBroken]) {
        if (failure) {
            failure(@"请求失败，请检查网络", NETWORK_ERROR, nil);
        }
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param addEntriesFromDictionary:parameters];
    
    
    [_sessionManager GET:[NSString stringWithFormat:@"%@",urlString] parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject){
            
            NSDictionary *dic=responseObject;
            
            if (dic&&[dic isKindOfClass:[NSDictionary class]]) {
                NSInteger errorCode = [[dic objectForKey:@"code"] integerValue];
                if ([[dic objectForKey:@"code"] intValue] == 200) {
                    if (success) {
                        success(dic, task);
                    }else{
                        NSString *errorMsg = [dic objectForKey:@"msg"];
                        
                        failure(errorMsg, errorCode, task);
                    }
                }else{
                    NSString *errorMsg = [dic objectForKey:@"msg"];
                    
                    failure(errorMsg, errorCode, task);
                }
                
            }else{
                if (failure) {
                    failure(@"请求失败,请重试", NETWORK_ERROR, task);
                }
            }
        }else{
            if (failure) {
                failure(@"请求失败,请重试", NETWORK_ERROR, task);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(@"请求失败,请重试", NETWORK_ERROR, task);
        }
    }];
}

- (void)setUserToken:(NSString *)token {
    [_sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
}

@end
