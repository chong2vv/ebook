//
//  YDBaseDataController.h
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YDCompletionBlock)(id responseData);
typedef void(^YDFailureBlock)(NSString *errorString, NSInteger errorCode);

@interface YDBaseDataController : NSObject

@end

NS_ASSUME_NONNULL_END
