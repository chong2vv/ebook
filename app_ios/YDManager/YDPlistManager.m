//
//  YDPlistManager.m
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDPlistManager.h"

@interface YDPlistManager ()

@property (atomic, strong) NSUserDefaults *userDefaults;

@end

@implementation YDPlistManager

+ (YDPlistManager *)sharedInstance {
    static YDPlistManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YDPlistManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if(self = [super init]) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

@end
