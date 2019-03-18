//
//  YDCommonUtil+YDHelp.h
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDCommonUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface YDCommonUtil (YDHelp)
//手机权限相关检测

/**
 * 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkPhotoLibraryAuthorizationStatus;

/**
 * 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkCameraAuthorizationStatus;


@end

NS_ASSUME_NONNULL_END
