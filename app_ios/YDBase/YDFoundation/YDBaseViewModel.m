//
//  YDBaseViewModel.m
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDBaseViewModel.h"

@implementation YDBaseViewModel

+ (YDBaseViewModel *)getViewModelWithData:(id)model {
    YDBaseViewModel *vm = [[YDBaseViewModel alloc] init];
    return vm;
}

@end
