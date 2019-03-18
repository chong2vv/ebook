//
//  YDUrlMacros.h
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#ifndef YDUrlMacros_h
#define YDUrlMacros_h

//内部版本号
#define VersionCode 1

#define DevelopHost    1
#define ProductHost    0

#if DevelopHost

/**开发服务器*/
#define YDBaseUrl @"https://www.miaobixiaoxiong.com/"

#elif ProductHost

/**生产服务器*/
#define YDBaseUrl @"https://www.miaobixiaoxiong.com/"
#endif



#endif /* YDUrlMacros_h */
