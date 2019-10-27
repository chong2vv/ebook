//
//  NSMutableSet+AvoidCrash.m
//  ArtChat
//
//  Created by 雷华 on 2017/7/7.
//
//

#import "NSMutableSet+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSMutableSet (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class setClass = NSClassFromString(@"__NSSetM");
        
        [AvoidCrash exchangeInstanceMethod:setClass method1Sel:@selector(addObject:) method2Sel:@selector(avoidCrashAddObject:)];
        
        [AvoidCrash exchangeInstanceMethod:setClass method1Sel:@selector(removeObject:) method2Sel:@selector(avoidCrashRemoveObject:)];
    });
}
//=================================================================
//                  来自 https://github.com/jasenhuang/NSObjectSafe
//=================================================================
- (void)avoidCrashAddObject:(id)anObject {
    @try {
        [self avoidCrashAddObject:anObject];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}
//=================================================================
//                  来自 https://github.com/jasenhuang/NSObjectSafe
//=================================================================
- (void)avoidCrashRemoveObject:(id)anObject {
    @try {
        [self avoidCrashRemoveObject:anObject];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}
@end
