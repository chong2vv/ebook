//
//  NSUserDefaults+AvoidCrash.m
//  ArtChat
//
//  Created by weijingyun on 2017/7/7.
//
//

#import "NSUserDefaults+AvoidCrash.h"
#import "AvoidCrash.h"

@implementation NSUserDefaults (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(objectForKey:) method2Sel:@selector(hookObjectForKey:)];
        
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(setObject:forKey:) method2Sel:@selector(hookSetObject:forKey:)];
        
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(removeObjectForKey:) method2Sel:@selector(hookRemoveObjectForKey:)];
        
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(integerForKey:) method2Sel:@selector(hookIntegerForKey:)];
        
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(boolForKey:) method2Sel:@selector(hookBoolForKey:)];
    });
}

- (id) hookObjectForKey:(NSString *)defaultName
{
    if (defaultName == nil) {
        return nil;
    }
    
    id object = nil;
    @try {
        object = [self hookObjectForKey:defaultName];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

- (NSInteger) hookIntegerForKey:(NSString *)defaultName
{
    if (defaultName == nil) {
        return 0;
    }
    NSInteger object = 0;
    @try {
        object = [self hookIntegerForKey:defaultName];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

- (BOOL) hookBoolForKey:(NSString *)defaultName
{
    if (defaultName == nil) {
        return NO;
    }
    BOOL object = NO;
    @try {
        object = [self hookBoolForKey:defaultName];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

- (void) hookSetObject:(id)value forKey:(NSString*)aKey
{
    if (aKey == nil) {
        return;
    }
    
    @try {
        [self hookSetObject:value forKey:aKey];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
    }
}

- (void) hookRemoveObjectForKey:(NSString*)aKey
{
    if (aKey == nil) {
        return;
    }
    
    @try {
        [self hookRemoveObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
    }
}

@end
