//
//  YDNetWorkCheckManager.m
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDNetWorkCheckManager.h"

@interface YDNetWorkCheckManager ()

@property (nonatomic, strong) Reachability *reachability;

@end


@implementation YDNetWorkCheckManager

+ (YDNetWorkCheckManager *)sharedInstance {
    static dispatch_once_t once;
    static YDNetWorkCheckManager *instance;
    dispatch_once(&once, ^ {
        instance = [[YDNetWorkCheckManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.reachability = [Reachability reachabilityForInternetConnection];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(networkDidChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        [self.reachability startNotifier];
    }
    return self;
}

- (BOOL)isNetworkBroken {
    NetworkStatus status = [self.reachability currentReachabilityStatus];
    if (status == NotReachable) {
        return YES;
    }else{
        return NO;
    }
}


-(NetworkStatus)getNetworkStatus{
    return [self checkNetworkStatusOnNotReachable:nil onReachableViaWWAN:nil onReachableViaWiFi:nil];
}

- (NetworkStatus)checkNetworkStatusOnNotReachable:(void (^)(void))onNotReachable
                               onReachableViaWWAN:(void (^)(void))onReachableViaWWAN
                               onReachableViaWiFi:(void (^)(void))onReachableViaWiFi {
    NetworkStatus status = [self.reachability currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            if (onNotReachable) {
                onNotReachable();
            }
            break;
        case ReachableViaWWAN:// 3G
            if (onReachableViaWWAN) {
                onReachableViaWWAN();
            }
            break;
        case ReachableViaWiFi:
            if (onReachableViaWiFi) {
                onReachableViaWiFi();
            }
            break;
    }
    return status;
}

- (void)networkDidChanged:(NSNotification *)sender {
    NetworkStatus status = [self.reachability currentReachabilityStatus];
    if (self.networkChanged) {
        self.networkChanged(status);
    }
}

@end
