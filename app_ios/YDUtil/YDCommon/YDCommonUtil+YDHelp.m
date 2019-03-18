//
//  YDCommonUtil+YDHelp.m
//  app_ios
//
//  Created by 王远东 on 2019/3/18.
//  Copyright © 2019 王远东. All rights reserved.
//

#import "YDCommonUtil+YDHelp.h"
#import <AVFoundation/AVFoundation.h>

@implementation YDCommonUtil (YDHelp)

+ (BOOL)checkPhotoLibraryAuthorizationStatus
{
    return YES;
}

+ (BOOL)checkCameraAuthorizationStatus
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return NO;
    }
    
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusDenied == authStatus ||
            AVAuthorizationStatusRestricted == authStatus) {
            return NO;
        }
    }
    
    return YES;
}

@end
