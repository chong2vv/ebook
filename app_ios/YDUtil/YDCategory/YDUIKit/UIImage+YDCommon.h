//
//  UIImage+YDCommon.h
//  app_ios
//
//  Created by 王远东 on 2019/3/17.
//  Copyright © 2019 王远东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YDCommon)

/**
 生成并返回纯颜色的image
 
 @param color  颜色
 */
+ (nullable UIImage *)imageWithColor:(UIColor *)color;

/**
 生成并返回固定尺寸的纯颜色image
 
 @param color  颜色
 @param size   尺寸
 */
+ (nullable UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 创建GIF对应比例的image
 
 @param data     GIF数据
 
 @param scale    指定比例
 
 @return GIF动画后的Image
 */
+ (nullable UIImage *)imageWithSmallGIFData:(NSData *)data scale:(CGFloat)scale;

/**
 判断是否是GIF
 
 @param data image数据
 
 */
+ (BOOL)isAnimatedGIFData:(NSData *)data;

/**
 判断是否是GIF
 
 @param path GIF图片路径
 
 */
+ (BOOL)isAnimatedGIFFile:(NSString *)path;

/**
 创建PDF的image
 
 @param dataOrPath PDF的data或者路径
 
 */
+ (nullable UIImage *)imageWithPDF:(id)dataOrPath;

/**
 创建PDF的image并指定大小
 
 @param dataOrPath  PDF的data或者路径
 
 @param size     生成PDF的大小
 
 */
+ (nullable UIImage *)imageWithPDF:(id)dataOrPath size:(CGSize)size;

/**
 图片左转90°. ⤺
 宽高兑换
 */
- (nullable UIImage *)imageByRotateLeft90;

/**
 图片右转90°. ⤼
 宽高兑换
 */
- (nullable UIImage *)imageByRotateRight90;

/**
 图片旋转 180° . ↻
 */
- (nullable UIImage *)imageByRotate180;


@end

NS_ASSUME_NONNULL_END
