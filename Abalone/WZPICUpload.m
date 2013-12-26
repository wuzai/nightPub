//
//  WZPICUpload.m
//  Abalone
//
//  Created by chen  on 13-12-2.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZPICUpload.h"
#import "RKObjectMapping+Null.h"

NSString *const WZUpLoadPicSucceedNotification=@"WZUpLoadPicSucceedNotification";
NSString *const WZUpLoadPicFailedNotification=@"WZUpLoadPicFailedNotification";


@implementation WZPICUpload

#pragma mark - Protocol

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"uploadpic";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    return [RKObjectMapping nullMapping];
}

+ (RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    return mapping;
}

+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZUpLoadPicSucceedNotification;
}

+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    return WZUpLoadPicFailedNotification;
}

+ (BOOL)upLoadPic:(NSString *)fileName by:(NSString *)imageData
{
    return [[WZNetworkHelper helper] help:[self class] with:@{@"fileName":fileName,@"data":imageData} object:nil by:RKRequestMethodGET];
}

+ (NSString *)messageForStatusCode:(NSInteger)statusCode path:(NSString *)path method:(RKRequestMethod)method
{
    NSString *message = nil;
    switch (statusCode) {
        case 410:
            message = @"密码错误";
            break;
        case 404:
            message = @"用户不存在";
            break;
        default:
            break;
    }
    return nil;
}



#pragma mark - Callbacks
+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
   }

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    
}
@end
