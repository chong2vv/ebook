//
//  YDTextView.h
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YDTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end

NS_ASSUME_NONNULL_END
