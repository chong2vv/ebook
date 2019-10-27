//
//  NSSet+AvoidCrash.m
//  ArtChat
//
//  Created by 雷华 on 2017/7/7.
//
//

#import "NSSet+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSSet (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AvoidCrash exchangeClassMethod:[self class] method1Sel:@selector(setWithObject:) method2Sel:@selector(AvoidCrashSetWithObject:)];
    });
}
//=================================================================
//                  来自 https://github.com/jasenhuang/NSObjectSafe
//=================================================================
+ (instancetype)AvoidCrashSetWithObject:(const id  _Nonnull __unsafe_unretained *)object {
    id instance = nil;
    
    @try {
        instance = [self AvoidCrashSetWithObject:object];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
    }
    @finally {
        return instance;
    }
    
}

@end
