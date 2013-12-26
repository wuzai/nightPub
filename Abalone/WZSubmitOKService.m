//
//  WZSubmitOKService.m
//  Abalone
//
//  Created by 吾在 on 13-5-7.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZSubmitOKService.h"
#import <RestKit/RestKit.h>
#import "RKObjectMapping+Null.h"
#import "WZMemberCard+Mapping.h"
#import "WZMeteringCard+Mapping.h"
#import "WZCoupon+Mapping.h"
#import "WZMemberService+Mapping.h"

static NSString *type;
 NSString *const kSubmitOkServiceSuccessNotificationKey = @"submitOkServiceSuccess";
 NSString *const kSubmitOKServiceFailNotificationKey = @"submitOkServiceFail";

@implementation WZSubmitOKService

+(BOOL)submitOkForLargessServiceID:(NSString *)serviceID withType:(NSString *)serviceType byUserID:(NSString *)userID withStoreID:(NSString  *)storeID;
{
    type = serviceType;
    return [[WZNetworkHelper helper] help:[self class] with:@{@"type":serviceType, @"activity_id":serviceID, @"user_id":userID,@"store_id":storeID} object:nil by:RKRequestMethodGET];
}

+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"acceptLargess";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    //(MemberCard/Coupon/MeteringCard)
    if ([type isEqualToString:@"MemberCard"]) {
        return [WZMemberCard  memberCardMapping];
    }else if([type isEqualToString:@"Coupon"]){
        return [WZCoupon couponMapping];
    }else if([type isEqualToString:@"MeteringCard"]){
        return [WZMeteringCard meteringCardMapping];
    }
    //扩展类型
    else {
        return [WZMemberService memberServiceMapping];
    }
    return nil;
}

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSubmitOkServiceSuccessNotificationKey object:results]; 
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    NSString *errorMessage;
    if (loader.response.statusCode == 404) {
        errorMessage = @"未找到相应服务";
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kSubmitOKServiceFailNotificationKey object:errorMessage];
}

@end
