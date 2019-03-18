//
//  YDTTTAttributedLabel.h
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "TTTAttributedLabel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^UITTTLabelTapBlock)(id aObj);

@interface YDTTTAttributedLabel : TTTAttributedLabel
-(void)addLongPressForCopy;
-(void)addLongPressForCopyWithBGColor:(UIColor *)color;
-(void)addTapBlock:(UITTTLabelTapBlock)block;
-(void)addDeleteBlock:(UITTTLabelTapBlock)block;

@end

NS_ASSUME_NONNULL_END
