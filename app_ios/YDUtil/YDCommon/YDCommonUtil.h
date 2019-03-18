//
//  YDCommonUtil.h
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^alertOkCallback)(void);
typedef void(^alertCancelCallback)(void);

typedef void (^actionSheetPhotograph)(void);
typedef void (^actionSheetPhotoAlbum)(void);

@interface YDCommonUtil : NSObject

/**
 * 获取text对象的宽度，加粗
 */
+ (CGFloat) getTextWidth:(NSString *) text fontSize:(float) fontSize withScreenWidth:(float) screenWidth bold:(BOOL)bold;

/**
 * 获取text对象的高度，加粗
 */
+ (CGFloat) getTextHeight:(NSString *) text fontSize:(float) fontSize withScreenWidth:(float) screenWidth bold:(BOOL)bold;

/**
 * 双色排版
 */
+ (NSAttributedString *)setAttributedString:(NSString *)firstString firstColor:(UIColor *)firstColor firstFont:(UIFont *)firstFont secondString:(NSString *)secondString sencondColor:(UIColor *)secondColor secondFont:(UIFont *)secontFont;

/**
 * 显示提示框
 */
+ (void) showHUDTips:(NSString *)title on:(UIView *)view;

/**
 * 显示提示框（window）
 */
+ (void) showHUDTips:(NSString *)title;

/**
 * 显示等待
 */
+ (void) showLoading;

/**
 * 隐藏等待
 */
+ (void) hiddenLoading;

/**
 * alert弹出
 */
+ (void) showAlertController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message rightButtonTitleName:(NSString *)rightButtonTitleName leftButtonTitleName:(NSString *)leftButtonTitleName alertOkCallback:(alertOkCallback )alertOkCallback alertCancelCallback:(alertCancelCallback ) alertCancelCallback;

/**
 * 选择拍照或者相册
 */
+ (void) showPicActionSheet:(UIViewController *)viewController;


@end

