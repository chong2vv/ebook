//
//  NSObject+RunTime.h
//  ArtStudio
//
//  Created by weijingyun on 2017/1/5.
//  Copyright © 2017年 kimziv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AvoidCrashRunTime)

// 获取固定前缀的所有方法名
- (NSArray <NSString *> *)getAvoidCrashMethodByListPrefix:(NSString *)prefix;
+ (NSArray <NSString *> *)getAvoidCrashMethodByListPrefix:(NSString *)prefix;

@end
