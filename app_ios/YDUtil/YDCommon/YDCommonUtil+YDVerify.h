//
//  YDCommonUtil+YDVerify.h
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDCommonUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface YDCommonUtil (YDVerify)

/**
 * 检查string是否为空，nil或""
 */
+ (BOOL)isStrNotEmpty:(NSString *) val;

/**
 * 校验邮箱
 */
+ (BOOL)validateEmail:(NSString *) email;

/**
 * 校验手机号
 */
+ (BOOL)validateMobileNumber:(NSString *) mobileNum;

/**
 * 校验手机号
 */
+ (BOOL)validatePassword:(NSString *) password;

/**
 * 校验验证码
 */
+ (BOOL)validateCodeNumber:(NSString *) text;

@end

NS_ASSUME_NONNULL_END
