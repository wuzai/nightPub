//
//  WZMessage+Networks.m
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMessage+Networks.h"
#import "WZMessage+Mapping.h"
#import "RKObjectMapping+Null.h"
#import "WZUser.h"
#import <RestKit/RestKit.h>

static NSString *const kUserDefaultsMessageTimeStampKey = @"WZMessageTimeStamp";

static inline NSString *messageTimeStampKey(NSString *uid)
{
    NSString *key = [NSString stringWithFormat:@"%@_%@",kUserDefaultsMessageTimeStampKey,uid];
    return key;
}

NSString *const WZDownloadMessageSucceedNotification = @"DownloadMessageSucceed";
NSString *const WZDownloadMessageFailedNotification = @"DownloadMessageFailed";

NSString *const WZSendMessageSucceedNotification = @"sendMessageSucceed";
NSString *const WZSendMessageFailedNotification = @"sendMessageFailed";

@implementation WZMessage (Networks)

#pragma mark Protocol
+ (NSString *)resoucePath
{
    return @"sendMessageRecords";
}



+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    switch (method) {
        case RKRequestMethodPUT:
            return [RKObjectMapping nullMapping];
            break;
        case RKRequestMethodGET:
            return [[self class] messageMapping];
        default:
            break;
    }
    return nil;
}

+ (RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    switch (method) {
        case RKRequestMethodPOST:
            ///return [[self class] serialMapping];
            break;
        case RKRequestMethodGET:
            return [RKObjectMapping nullMapping];
            break;
        default:
            break;
    }
    return nil;
}

+ (NSString *)succeedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    NSString *notificationName = nil;
    switch (method) {
        case RKRequestMethodPOST:
            notificationName = WZSendMessageSucceedNotification;
            break;
        case RKRequestMethodGET:
            notificationName = WZDownloadMessageSucceedNotification;
            break;
        default:
            break;
    }
    return notificationName;
}



+ (NSString *)failedNotificationNameForPath:(NSString *)path method:(RKRequestMethod)method
{
    NSString *notificationName = nil;
    switch (method) {
        case RKRequestMethodPOST:
            notificationName = WZSendMessageFailedNotification;
            break;
        case RKRequestMethodGET:
            notificationName = WZSendMessageSucceedNotification;
            break;
        default:
            break;
    }
    return notificationName;
}


+ (NSString *)messageForStatusCode:(NSInteger)statusCode path:(NSString *)path method:(RKRequestMethod)method
{
    NSString *message = nil;
    switch (statusCode) {
        case 400:
            message = @"参数有误";
            break;
        case 404:
            message = @"用户不存在";
            break;
        default:
            break;
    }
    return message;
}

#pragma mark - Interface
+ (BOOL)downloadMessagesForUser:(WZUser *)user
{
    if (user) {
        NSString *uid = user.gid;
        NSDate *timeStamp = [[NSUserDefaults standardUserDefaults] objectForKey:messageTimeStampKey(uid)];
        if (!timeStamp) {
            timeStamp = [NSDate dateWithTimeIntervalSince1970:0];
        }
        return [[WZNetworkHelper helper] help:[self class] with:@{@"user_id":uid,@"&timestamp":timeStamp} object:nil by:RKRequestMethodGET];
    }
    return NO;
}


+(void)sendMessage:(NSString *)str by:(WZUser *)user toUserId:(WZUser *)toUser
{
    if (user) {
        NSString *uid = user.gid;
        NSDate *timeStamp = [[NSUserDefaults standardUserDefaults] objectForKey:messageTimeStampKey(uid)];
        if (!timeStamp) {
            timeStamp = [NSDate dateWithTimeIntervalSince1970:0];
        }
         [[WZNetworkHelper helper] help:[self class] with:@{@"toUserId":toUser.gid,@"sentTime":timeStamp,@"content":str,@"owner":user.gid} object:nil by:RKRequestMethodPOST];
    }
}

#pragma mark - Callbacks
+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [loader.URL.queryParameters objectForKey:@"user_id"];
    [defaults setObject:[NSDate date] forKey:messageTimeStampKey(uid)];
    [defaults synchronize];
}



+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter]  postNotificationName:WZDownloadMessageFailedNotification object:error];
}

@end
