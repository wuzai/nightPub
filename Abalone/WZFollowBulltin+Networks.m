//
//  WZFollowBulltin+Networks.m
//  Abalone
//
//  Created by chen  on 13-11-28.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZFollowBulltin+Networks.h"
#import "RKObjectMapping+Null.h"
#import "RKObjectLoader+Scheme.h"
#import "WZFollowBulltin+Mapping.h"

@implementation WZFollowBulltin (Networks)

NSString *const WZFollowBulletinAddSuccessNotification=@"WZFollowBulletinAddSucceedNotification";
NSString *const WZFollowBulletinAddFailedNotification=@"WZFollowBulletinAddFailedNotification";

+ (void)addFollowBulletin:(NSString *)content by:(WZUser *)user forBulletinId:(NSString *)bulletinID
{
    NSDictionary *dic = @{@"bulletin_id":bulletinID,@"user_id":user.gid,@"content":content};
    [[WZNetworkHelper helper] help:[self class] with:nil object:dic by:RKRequestMethodPOST];
}



+(RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"bulletin_id",@"user_id",@"content", nil];
    return mapping;
}


#pragma mark - Protocol
+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"followBulletins";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    switch (method) {
        case RKRequestMethodPOST:
            return [WZFollowBulltin followBulletinMapping];
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
        case RKRequestMethodPUT:
            notificationName = WZFollowBulletinAddSuccessNotification;
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
        case RKRequestMethodPUT:
            notificationName = WZFollowBulletinAddFailedNotification;
            break;
       
        default:
            break;
    }
    return notificationName;
}


#pragma mark - CallBacks

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodPOST) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WZFollowBulletinAddSuccessNotification  object:results]; //添加对返回值的处理
        
    }
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodPOST) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WZFollowBulletinAddFailedNotification  object:error];
        
    }
}


@end
