//
//  NSMutableString+AvoidCrash.m
//  AvoidCrashDemo
//
//  Created by mac on 16/10/6.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSMutableString+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSMutableString (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class stringClass = NSClassFromString(@"__NSCFString");
        
        //replaceCharactersInRange
        [AvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(replaceCharactersInRange:withString:) method2Sel:@selector(avoidCrashReplaceCharactersInRange:withString:)];
        
        //insertString:atIndex:
        [AvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(insertString:atIndex:) method2Sel:@selector(avoidCrashInsertString:atIndex:)];
        
        //deleteCharactersInRange
        [AvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(deleteCharactersInRange:) method2Sel:@selector(avoidCrashDeleteCharactersInRange:)];
        
        //=================================================================
        //                  来自 https://github.com/jasenhuang/NSObjectSafe
        //=================================================================
        [AvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(appendString:) method2Sel:@selector(hookAppendString:)];
        
        [AvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(insertString:atIndex:) method2Sel:@selector(hookInsertString:atIndex:)];
        
        //substringWithRange:
        [AvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(substringWithRange:) method2Sel:@selector(avoidCrashSubstringWithRange:)];
    });
}

#pragma mark - substringWithRange:

- (NSString *)avoidCrashSubstringWithRange:(NSRange)range {
    
    NSString *subString = nil;
    
    @try {
        subString = [self avoidCrashSubstringWithRange:range];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

//=================================================================
//                     replaceCharactersInRange
//=================================================================
#pragma mark - replaceCharactersInRange

- (void)avoidCrashReplaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    
    @try {
        [self avoidCrashReplaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

//=================================================================
//                     insertString:atIndex:
//=================================================================
#pragma mark - insertString:atIndex:

- (void)avoidCrashInsertString:(NSString *)aString atIndex:(NSUInteger)loc {
    
    @try {
        [self avoidCrashInsertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

//=================================================================
//                   deleteCharactersInRange
//=================================================================
#pragma mark - deleteCharactersInRange

- (void)avoidCrashDeleteCharactersInRange:(NSRange)range {
    
    @try {
        [self avoidCrashDeleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}


//=================================================================
//                  来自 https://github.com/jasenhuang/NSObjectSafe
//=================================================================
- (void) hookAppendString:(NSString *)aString
{
    @try {
        [self hookAppendString:aString];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

- (void) hookInsertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    @try {
        [self hookInsertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}




@end
