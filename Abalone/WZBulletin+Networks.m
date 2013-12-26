//
//  WZBulletin+Networks.m
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZBulletin+Networks.h"
#import "WZBulletin+Mapping.h"
#import "RKObjectMapping+Null.h"
#import "RKObjectLoader+Scheme.h"

 NSString *const WZBulletinGetSucceedNotification=@"bulletinGetSuccess";
 NSString *const WZBulletinGetFailedNotification=@"bulletinGetFail";

NSString *const WZBulletinAddSuccessNotification=@"WZBulletinAddSucceedNotification";
NSString *const WZBulletinAddFailedNotification=@"WZBulletinAddFailedNotification";



@implementation WZBulletin (Networks)


#pragma mark - Protocol
+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"bulletins";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    switch (method) {
        case RKRequestMethodPUT:
            return [RKObjectMapping nullMapping];
            break;
        case RKRequestMethodGET:
            return [[self class] bulletinMapping];
        case RKRequestMethodPOST:
            return [[self class] bulletinMapping];
            break;
        default:
            break;
    }
    return nil;
}


#pragma mark - Interface
+ (BOOL)fetchBulletin
{
    return [[WZNetworkHelper helper] help:[self class] with:nil object:self by:RKRequestMethodGET];
}

+(void)createBulletin:(NSString *)content with:(NSString *)title by:(WZUser *)user
{
    NSDictionary *dic = @{@"title":title,@"content":content,@"user_id":user.gid};
     [[WZNetworkHelper helper] help:[self class] with:nil object:dic by:RKRequestMethodPOST];
}

+(RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"title",@"user_id",@"content", nil];
    return mapping;
}




#pragma mark - CallBacks

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    if([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET){
        [[NSNotificationCenter defaultCenter] postNotificationName:WZBulletinGetSucceedNotification  object:results];
    }
    else
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:WZBulletinAddSuccessNotification  object:results];
    }
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WZBulletinGetFailedNotification  object:error];
        
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:WZBulletinAddFailedNotification  object:error];    }
}
@end
