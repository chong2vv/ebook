//
//  YDAppDelegate+YDAppService.m
//  app_ios
//
//  Created by 王远东 on 2019/3/17.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDAppDelegate+YDAppService.h"

@interface YDAppDelegate()

@end

@implementation YDAppDelegate (YDAppService)

// 初始化window
- (void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //常规写法，同一界面响应时的排他性
    [[UIButton appearance] setExclusiveTouch:YES];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }

}

// 初始化各种第三方SDK
- (void)initSDK {
    
}

@end
