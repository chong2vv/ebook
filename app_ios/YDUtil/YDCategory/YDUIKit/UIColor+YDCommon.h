//
//  UIColor+YDCommon.h
//  app_ios
//
//  Created by 王远东 on 2019/3/17.
//  Copyright © 2019 王远东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YDCommon)

/**
 获取16进制颜色
 */
+ (nullable UIColor *)colorWithHexString:(NSString *)hexStr;

/**
 获取颜色的16进制值
 */
- (nullable NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
