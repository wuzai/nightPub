//
//  WZPICUpload.h
//  Abalone
//
//  Created by chen  on 13-12-2.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WZNetworkHelper.h"

extern NSString *const WZUpLoadPicSucceedNotification;
extern NSString *const WZUpLoadPicFailedNotification;

@interface WZPICUpload : NSObject <WZNetworkBeggar>

+ (BOOL)upLoadPic:(NSString *)fileName by:(NSString *)imageData;

@end