//
//  YDUploadImageManager.m
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDUploadImageManager.h"
#import "YDNetWorkCheckManager.h"

@interface YDUploadImageManager ()

@property(nonatomic,strong) AFHTTPSessionManager *manager;

@end

static const NSInteger NETWORK_ERROR = 1000001;

@implementation YDUploadImageManager
static id _instance = nil;

+ (YDUploadImageManager *)sharedInstance{
    //只进行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[YDUploadImageManager alloc] init];
    });
    return _instance;
}

-(instancetype)init{
    if(self=[super init]){
        self.manager = [AFHTTPSessionManager manager];
        //设置超时时间
        self.manager.requestSerializer.timeoutInterval = 20;
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    }
    return self;
}

-(void)uploadFile:(UIImage *)file imageName:(NSString *)imageName success:(CompletionBlock)success failure:(FailureBlock)failure {
    
    if([[YDNetWorkCheckManager sharedInstance] isNetworkBroken]) {
        if (failure) {
            failure(@"", NETWORK_ERROR, nil);
        }
        return;
    }
}
@end
