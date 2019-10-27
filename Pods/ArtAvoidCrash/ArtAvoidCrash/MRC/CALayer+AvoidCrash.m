//
//  CALayer+AvoidCrash.m
//  ArtChat
//
//  Created by weijingyun on 2017/8/7.
//
//

#import "CALayer+AvoidCrash.h"
#import "AvoidCrash.h"

#define AvoidCrashDefaultBounds     @"设置为CGRectMake(1, 1, 1, 1)"

@implementation CALayer (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //replaceCharactersInRange
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(setFrame:) method2Sel:@selector(avoidCrashSetFrame:)];
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(setBounds:) method2Sel:@selector(avoidCrashSetBounds:)];
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(setPosition:) method2Sel:@selector(avoidCrashSetPosition:)];
    });
}

- (void)avoidCrashSetBounds:(CGRect)bounds {
    
    @try {
        [self avoidCrashSetBounds:bounds];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultBounds;
        bounds = CGRectMake(1, 1, 1, 1);
        [self avoidCrashSetBounds:bounds];
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

- (void)avoidCrashSetFrame:(CGRect)frame {
    @try {
        [self avoidCrashSetFrame:frame];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultBounds;
        frame = CGRectMake(1, 1, 1, 1);
        [self avoidCrashSetBounds:frame];
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

- (void)avoidCrashSetPosition:(CGPoint)position {
    @try {
        [self avoidCrashSetPosition:position];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultBounds;
        [self avoidCrashSetPosition:CGPointMake(1, 1)];
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    } @finally {
        
    }
}

@end
