//
//  AvoidCrash.m
//  AvoidCrash
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "AvoidCrash.h"
#import "NSObject+AvoidCrashRunTime.h"

#define AvoidCrashSeparator         @"================================================================"
#define AvoidCrashSeparatorWithFlag @"========================AvoidCrash Log=========================="

#define key_errorName        @"errorName"
#define key_errorReason      @"errorReason"
#define key_errorPlace       @"errorPlace"
#define key_defaultToDo      @"defaultToDo"
#define key_callStackSymbols @"callStackSymbols"
#define key_exception        @"exception"
#define key_currentThread    @"currentThread"

static void(^ArtAvoidCrashBlock)(NSException *exception,NSString *defaultToDo,BOOL upload);

@implementation AvoidCrash

/**
 * 设置信息回掉收集
 */
+ (void)setupBlock:(void(^)(NSException *exception,NSString *defaultToDo,BOOL upload))aBlock {
    ArtAvoidCrashBlock = aBlock;
}

+ (void)becomeEffective:(NSArray<NSString *> *)openavoidcrash {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (openavoidcrash.count <= 0) { // 服务器不返回就 默认全部拦截
            [self becomeAllEffective];
            return;
        }
        
        [NSObject avoidCrashForwardingExchangeMethod];
        AvoidCrash * avoidCrash = [AvoidCrash new];
        __block BOOL openAvoidCrash = YES;
        [openavoidcrash enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj rangeOfString:@"avoidCrash_"].length > 0) {
                openAvoidCrash = NO;
                SEL sel = NSSelectorFromString(obj);
                if ([avoidCrash respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    [avoidCrash performSelector:sel];
#pragma clang diagnostic pop
                }
            }else {
                Class voidCrashClass = NSClassFromString(obj);
                [voidCrashClass avoidCrashExchangeMethod];
            }
        }];
        
        if (openAvoidCrash) {
            [avoidCrash avoidCrashEffective];
        }
        
    });
}

+ (void)becomeAllEffective {
    
    [NSObject avoidCrashForwardingExchangeMethod];
    [NSObject avoidCrashExchangeMethod];
    
    [NSAttributedString avoidCrashExchangeMethod];
    [NSMutableAttributedString avoidCrashExchangeMethod];
    
    [NSArray avoidCrashExchangeMethod];
    [NSMutableArray avoidCrashExchangeMethod];

    [NSDictionary avoidCrashExchangeMethod];
    [NSMutableDictionary avoidCrashExchangeMethod];
    
    [NSSet avoidCrashExchangeMethod];
    [NSMutableSet avoidCrashExchangeMethod];
    
    [NSOrderedSet avoidCrashExchangeMethod];
    [NSMutableOrderedSet avoidCrashExchangeMethod];

    [NSString avoidCrashExchangeMethod];
    [NSMutableString avoidCrashExchangeMethod];

    [NSUserDefaults avoidCrashExchangeMethod];

    [UIView avoidCrashExchangeMethod];
    [CALayer avoidCrashExchangeMethod];
    
    [[AvoidCrash new] avoidCrashEffective];
}


- (void)avoidCrashEffective {
    NSArray<NSString *> * list = [self getAvoidCrashMethodByListPrefix:@"avoidCrash_"];
    [list enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEL sel = NSSelectorFromString(obj);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:sel];
#pragma clang diagnostic pop
    }];
}

/**
 *  类方法的交换
 *
 *  @param anClass    哪个类
 *  @param method1Sel 方法1
 *  @param method2Sel 方法2
 */
+ (void)exchangeClassMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {
    Method method1 = class_getClassMethod(anClass, method1Sel);
    Method method2 = class_getClassMethod(anClass, method2Sel);
    method_exchangeImplementations(method1, method2);
}


/**
 *  对象方法的交换
 *
 *  @param anClass    哪个类
 *  @param method1Sel 方法1(原本的方法)
 *  @param method2Sel 方法2(要替换成的方法)
 */
+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {
    
    
    Method originalMethod = class_getInstanceMethod(anClass, method1Sel);
    Method swizzledMethod = class_getInstanceMethod(anClass, method2Sel);
    
    BOOL didAddMethod =
    class_addMethod(anClass,
                    method1Sel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(anClass,
                            method2Sel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}



/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbolStr 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */

+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString* tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                
                //get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                
                //filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                    
                }
                *stop = YES;
            }
        }];
        
        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    
    return mainCallStackSymbolMsg;
}


/**
 *  提示崩溃的信息(控制台输出、通知)
 *
 *  @param exception   捕获到的异常
 *  @param defaultToDo 这个框架里默认的做法
 */
+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo {
    [self noteErrorWithException:exception defaultToDo:defaultToDo upload:YES];
}

+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo upload:(BOOL)upload {
    if (ArtAvoidCrashBlock) {
        ArtAvoidCrashBlock(exception,defaultToDo,upload);
    }
#ifdef DEBUG
    
    //堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    NSString *currentThread = [NSString stringWithFormat:@"%@",[NSThread currentThread]];
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr];

    if (mainCallStackSymbolMsg == nil) {

        mainCallStackSymbolMsg = @"崩溃方法定位失败,请您查看函数调用栈来排查错误原因";

    }

    NSString *errorName = exception.name;
    NSString *errorReason = exception.reason;
    //errorReason 可能为 -[__NSCFConstantString avoidCrashCharacterAtIndex:]: Range or index out of bounds
    //将avoidCrash去掉
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"avoidCrash" withString:@""];

    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];

    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@\n\n%@\n\n",AvoidCrashSeparatorWithFlag, errorName, errorReason, errorPlace, defaultToDo, AvoidCrashSeparator];
    AvoidCrashLog(@"%@",logErrorMessage);

    //请忽略下面的赋值，目的只是为了能顺利上传cocoapods
    logErrorMessage = logErrorMessage;

    NSDictionary *errorInfoDic = @{
                                   key_errorName        : errorName,
                                   key_errorReason      : errorReason,
                                   key_errorPlace       : errorPlace,
                                   key_defaultToDo      : defaultToDo,
                                   key_exception        : exception,
                                   key_callStackSymbols : callStackSymbolsArr,
                                   key_currentThread    : currentThread
                                   };
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *message = [NSString stringWithFormat:@"%@",errorInfoDic];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    });
#endif
    
}


@end
