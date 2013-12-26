//
//  WZUser+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZUser+Mapping.h"
#import "WZMemberCard+Mapping.h"
#import "WZCoupon+Mapping.h"
#import "WZMeteringCard+Mapping.h"
#import "WZMember+Mapping.h"
#import "WZConfigure+Mapping.h"
#import "WZMemberService+Mapping.h"

@implementation WZUser (Mapping)
+ (RKObjectMapping *)userMapping
{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:[self class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    [mapping mapKeyPath:@"userName" toAttribute:@"username"];
    [mapping mapAttributes:@"gender",@"name",@"email",@"birth",@"faceIcon",@"postImage",@"location", nil];
    [mapping mapKeyPath:@"userPoint" toAttribute:@"point"];
    [mapping mapKeyPath:@"_id" toAttribute:@"gid"];
    
    mapping.primaryKeyAttribute = @"gid";
    
    [mapping mapRelationship:@"config" withMapping:[WZConfigure configMapping]];
    return mapping;
}

+ (RKObjectMapping *)registerMapping
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"username",@"password",@"captcha", nil];
    return mapping;
}

+ (RKObjectMapping *)serialMapping
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"gender",@"name",@"email",@"birth",@"faceIcon",@"username",@"postImage",@"location", nil];//HTTP Body: {"gender":"男","name":"345","email":"566"}.
    return mapping;
}

+ (RKObjectMapping *)serviceMapping
{
    RKManagedObjectMapping *userMapping = [RKManagedObjectMapping mappingForClass:[WZUser class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    userMapping.primaryKeyAttribute = @"gid";
    [userMapping mapKeyPathsToAttributes:@"_id",@"gid",@"userName",@"username", nil];
    [userMapping mapKeyPath:@"userPoint" toAttribute:@"point"];
    
    [userMapping mapRelationship:@"memberCards"  withMapping:[WZMemberCard memberCardMapping]];
    [userMapping mapRelationship:@"coupons" withMapping:[WZCoupon couponMapping]];
    [userMapping mapRelationship:@"meteringCards" withMapping:[WZMeteringCard meteringCardMapping]];
    //扩展类型
   [userMapping mapRelationship:@"memberServices" withMapping:[WZMemberService memberServiceMapping]];
    [userMapping mapRelationship:@"members" withMapping:[WZMember memberMapping]];
    
    return userMapping;
}



@end
