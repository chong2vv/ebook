//
//  UIView+AvoidCrash.m
//  ArtChat
//
//  Created by weijingyun on 2017/8/4.
//
//

#import "UIView+AvoidCrash.h"
#import "AvoidCrash.h"

#define AvoidCrashDefaultBounds     @"设置为CGRectMake(1, 1, 1, 1)"

@implementation UIView (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //replaceCharactersInRange
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(setFrame:) method2Sel:@selector(avoidCrashSetFrame:)];
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(setBounds:) method2Sel:@selector(avoidCrashSetBounds:)];
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

@end
