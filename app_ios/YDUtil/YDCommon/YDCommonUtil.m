//
//  YDCommonUtil.m
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDCommonUtil.h"
#import "YDCommonUtil+YDVerify.h"

@implementation YDCommonUtil

+ (CGFloat)getTextWidth:(NSString *) text fontSize:(float) fontSize withScreenWidth:(float) screenWidth bold:(BOOL)bold {
    if ([YDCommonUtil isStrNotEmpty:text]) {
        CGSize constraint = CGSizeMake(screenWidth - (14 * 2), 20000.0f);
        
        if(fontSize <= 0) {
            fontSize = 14;
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        if(bold) {
            CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
            return size.width;
        }
        else {
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
            return size.width;
        }
#pragma clang diagnostic pop
    }
    else
        return 0;
}

+ ( CGSize )getStringRect:( NSString *)aString {
    CGSize  size;
    
    NSAttributedString * atrString = [[ NSAttributedString alloc ]  initWithString :aString];
    
    NSRange  range =  NSMakeRange ( 0 , atrString. length );
    
    NSDictionary * dic = [atrString  attributesAtIndex : 0   effectiveRange :&range];
    
    return size;
}

+ (CGFloat)getTextHeight:(NSString *) text fontSize:(float) fontSize withScreenWidth:(float) screenWidth bold:(BOOL)bold {
    if ([self isStrNotEmpty:text]) {
        CGSize constraint = CGSizeMake(screenWidth - (14 * 2), 20000.0f);
        
        if(fontSize <= 0) {
            fontSize = 14;
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        if(bold) {
            CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
            return size.height;
        }
        else {
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
            return size.height;
        }
#pragma clang diagnostic pop
        
    }
    else
        return 0;
}

+ (void)showHUDTips:(NSString *)title on:(UIView *)view {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.label.text = title;
    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:3];
}

+ (void)showHUDTips:(NSString *)title {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow ];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.label.text = title;
    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:3];
}

+ (void)showLoading {
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (void)hiddenLoading {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (NSAttributedString *)setAttributedString:(NSString *)firstString firstColor:(UIColor *)firstColor firstFont:(UIFont *)firstFont secondString:(NSString *)secondString sencondColor:(UIColor *)secondColor secondFont:(UIFont *)secontFont {
    if (firstString.length <= 0 || secondString.length <= 0) {
        return nil;
    }
    NSRange r1 = NSMakeRange(0, firstString.length);
    NSRange r2 = NSMakeRange(firstString.length, secondString.length);
    
    NSString * str = [NSString stringWithFormat:@"%@%@", firstString, secondString];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttribute:NSFontAttributeName value:firstFont range:r1];
    [attrStr addAttribute:NSFontAttributeName value:secontFont range:r2];
    [attrStr addAttribute:NSForegroundColorAttributeName value:firstColor range:r1];
    [attrStr addAttribute:NSForegroundColorAttributeName value:secondColor range:r2];
    
    return attrStr;
}

+ (void)showAlertController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message rightButtonTitleName:(NSString *)rightButtonTitleName leftButtonTitleName:(NSString *)leftButtonTitleName alertOkCallback:(alertOkCallback)alertOkCallback alertCancelCallback:(alertCancelCallback)alertCancelCallback{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:rightButtonTitleName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK Action");
        
        alertOkCallback();
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:leftButtonTitleName style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
        alertCancelCallback();
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

+ (void)showPicActionSheet:(UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate> *)viewController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *showAllInfoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        // 若设备支持相机，使用拍照功能；否则从照片库中选择
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        imagePicker.delegate = viewController; //设置委托
        imagePicker.allowsEditing = YES;
        [viewController presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *pickAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        // 若设备支持相机，使用拍照功能；否则从照片库中选择
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        imagePicker.delegate = viewController; //设置委托，
        imagePicker.allowsEditing = YES;
        [viewController presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:pickAction];
    [alert addAction:showAllInfoAction];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}

+ (NSString *)getUUID {
    
    NSString *UUIDString = [[NSUUID UUID] UUIDString];
    
    return [UUIDString lowercaseStringWithLocale:[NSLocale currentLocale]];
}

+ (NSString *)getVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version =  [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return version;
}

@end
