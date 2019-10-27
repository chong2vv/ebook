//
//  NSOrderedSet+AvoidCrash.m
//  ArtChat
//
//  Created by 雷华 on 2017/7/7.
//
//

#import "NSOrderedSet+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSOrderedSet (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [AvoidCrash exchangeClassMethod:[self class] method1Sel:@selector(orderedSetWithObjects:) method2Sel:@selector(AvoidCrashOrderedSetWithObjects:)];
        
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(initWithObject:) method2Sel:@selector(avoidInitWithObject:)];
        Class __orderSetI = NSClassFromString(@"__NSOrderedSetI");
        [AvoidCrash exchangeInstanceMethod:__orderSetI method1Sel:@selector(objectAtIndex:) method2Sel:@selector(avoidCrashObjectAtIndex:)];
    
    });
}


//=================================================================
//                  来自 https://github.com/jasenhuang/NSObjectSafe
//=================================================================
+ (instancetype)AvoidCrashOrderedSetWithObjects:(const id  _Nonnull __unsafe_unretained *)object {
    id instance = nil;
    
    @try {
        instance = [self AvoidCrashOrderedSetWithObjects:object];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
    }
    @finally {
        return instance;
    }
    
}

//=================================================================
//                  来自 https://github.com/jasenhuang/NSObjectSafe
//=================================================================
- (instancetype)avoidInitWithObject:(const id  _Nonnull __unsafe_unretained *)object  {
    id instance = nil;
    
    @try {
        instance = [self avoidInitWithObject:object];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
    }
    @finally {
        return instance;
    }

}

//=================================================================
//                  来自 https://github.com/jasenhuang/NSObjectSafe
//=================================================================
- (id)avoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self avoidCrashObjectAtIndex:index];
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
