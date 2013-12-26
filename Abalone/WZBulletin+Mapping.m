//
//  WZBulletin+Mapping.m
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZBulletin+Mapping.h"
#import "WZUser+Mapping.h"
#import "WZFollowBulltin+Mapping.h"
@implementation WZBulletin (Mapping)

+(RKManagedObjectMapping *)bulletinMapping
{
    RKManagedObjectMapping *bulletinServiceMapping = [RKManagedObjectMapping mappingForClass:[WZBulletin class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    bulletinServiceMapping.primaryKeyAttribute = @"gid";
    [bulletinServiceMapping mapKeyPathsToAttributes:@"_id",@"gid", nil];
    
    [bulletinServiceMapping mapAttributes:@"title",@"content"
     ,@"createAt",@"postImages",  nil];
    
//    [bulletinServiceMapping mapRelationship:@"user" withMapping:[WZUser userMapping]];
    [bulletinServiceMapping mapRelationship:@"followBulletins" withMapping:[WZFollowBulltin followBulletinMapping]];
    return bulletinServiceMapping;
}

@end
