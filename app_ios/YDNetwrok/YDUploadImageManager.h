//
//  YDUploadImageManager.h
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(id responseData, NSURLSessionDataTask *task);
typedef void(^FailureBlock)(NSString *errorString, NSInteger errorCode, NSURLSessionDataTask *task);

@interface YDUploadImageManager : NSObject

+(YDUploadImageManager *)sharedInstance;
/**
 上传头像
 
 @param file 上传的图片
 */
-(void)uploadFile:(UIImage *)file imageName:(NSString *)imageName
          success:(CompletionBlock)success failure:(FailureBlock)failure;

@end
