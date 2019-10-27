//
//  NSMutableDictionary+AvoidCrash.m
//  AvoidCrash
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSMutableDictionary+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSMutableDictionary (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
        
        //setObject:forKey:
        [AvoidCrash exchangeInstanceMethod:dictionaryM method1Sel:@selector(setObject:forKey:) method2Sel:@selector(avoidCrashSetObject:forKey:)];
        
        [AvoidCrash exchangeInstanceMethod:dictionaryM method1Sel:@selector(setObject:forKeyedSubscript:) method2Sel:@selector(avoidCrashSetObject:forKeyedSubscript:)];
        
        
        //objectForKey:
        [AvoidCrash exchangeInstanceMethod:dictionaryM method1Sel:@selector(objectForKey:) method2Sel:@selector(avoidCrashObjectForKey:)];
        
        
        //removeObjectForKey:
        Method removeObjectForKey = class_getInstanceMethod(dictionaryM, @selector(removeObjectForKey:));
        Method avoidCrashRemoveObjectForKey = class_getInstanceMethod(dictionaryM, @selector(avoidCrashRemoveObjectForKey:));
        method_exchangeImplementations(removeObjectForKey, avoidCrashRemoveObjectForKey);
    });
}


//=================================================================
//                       setObject:forKey:
//=================================================================
#pragma mark - setObject:forKey:
- (void)avoidCrashSetObject:(id)anObject forKeyedSubscript:(id<NSCopying>)aKey {
    @try {
        [self avoidCrashSetObject:anObject forKeyedSubscript:aKey];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}

- (void)avoidCrashSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    @try {
        [self avoidCrashSetObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}

//=================================================================
//                       removeObjectForKey:
//=================================================================
#pragma mark - removeObjectForKey:

- (void)avoidCrashRemoveObjectForKey:(id)aKey {
    
    @try {
        [self avoidCrashRemoveObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}

- (id)avoidCrashObjectForKey:(id)aKey {
    id object = nil;
    
    @try {
        object = [self avoidCrashObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}



@end
