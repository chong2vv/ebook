//
//  YDNetWorkCheckManager.h
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface YDNetWorkCheckManager : NSObject

+ (YDNetWorkCheckManager *)sharedInstance;

//网路是否可用
- (BOOL)isNetworkBroken;

// 获取当前网络状态
- (NetworkStatus)getNetworkStatus;

//获取当前网络状态 并获得相应回调
- (NetworkStatus)checkNetworkStatusOnNotReachable:(void (^)(void))onNotReachable
                               onReachableViaWWAN:(void (^)(void))onReachableViaWWAN
                               onReachableViaWiFi:(void (^)(void))onReachableViaWiFi;

//监听网络状态改变
@property (nonatomic, copy) void (^networkChanged)(NetworkStatus);


@end

