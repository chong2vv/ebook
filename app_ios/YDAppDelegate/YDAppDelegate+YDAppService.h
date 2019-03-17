//
//  YDAppDelegate+YDAppService.h
//  app_ios
//
//  Created by 王远东 on 2019/3/17.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDAppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface YDAppDelegate (YDAppService)

//初始化Window
- (void)initWindow;

//初始化使用的第三方SDK
- (void)initSDK;

@end

NS_ASSUME_NONNULL_END
