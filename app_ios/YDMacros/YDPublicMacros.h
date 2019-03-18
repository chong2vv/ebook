//
//  YDPublicMacros.h
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#ifndef YDPublicMacros_h
#define YDPublicMacros_h

#define YDSCREEN_BOUNDS       ([UIScreen mainScreen].bounds)
#define YDSCREEN_SIZE         ([UIScreen mainScreen].bounds.size)
#define YDSCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
#define YDSCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)
#define YDNAV_BAR_Bootom      self.navigationController.navigationBar.mas_bottom
#define YDTAB_BAR_TOP         self.tabBarController.tabBar.mas_top
#define YDNAV_BAR_HEIGHT      self.navigationController.navigationBar.size.height
#define YDSCREEN_MIN MIN(YDSCREEN_HEIGHT,MSCREEN_WIDTH)
#define YDSCREEN_MAX MAX(YDSCREEN_HEIGHT,MSCREEN_WIDTH)
#define YDBOTTOM_SAFEAREA_HEIGHT (YDIS_IPHONE_X? 34 : 0)

#define YDSTATUS_HEIGHT   (YDIS_IPHONE_X?34:0)

//资产cell高度设置
#define YDCELL_HIGH_NORMAL     53
#define YDCELL_HIGH_SEL        143

//CYL设置
#define MDEPRECATED(explain) __attribute__((deprecated(explain)))
#define MIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define YDIS_IOS_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)
#define YDIS_IPHONE_X ({BOOL isPhoneX = NO;if (@available(iOS 11.0, *)) {isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;}(isPhoneX);})

#endif /* YDPublicMacros_h */
