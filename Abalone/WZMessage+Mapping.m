//
//  WZMessage+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-19.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMessage+Mapping.h"
#import "WZUser+Mapping.h"
#import "WZMerchant+Mapping.h"
#import "WZStore+Mapping.h"

@implementation WZMessage (Mapping)
+ (RKObjectMapping *)messageMapping
{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:[self class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    [mapping mapAttributes:@"owner",@"content",@"sentTime",@"toUserId",nil];
    [mapping mapKeyPath:@"_id" toAttribute:@"gid"];
    mapping.primaryKeyAttribute = @"gid";
    
    
//    [mapping mapRelationship:@"to" withMapping:[WZUser userMapping]];
//    [mapping connectRelationship:@"to" withObjectForPrimaryKeyAttribute:@"toID"];
    
    
    [mapping mapRelationship:@"send" withMapping:[WZUser userMapping]];
    [mapping connectRelationship:@"send" withObjectForPrimaryKeyAttribute:@"owner"];
    
    return mapping;
}




+ (RKObjectMapping *)serialMapping
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"sentTime",@"owner",@"toUserId",@"content", nil];//    return mapping;
}
@end
