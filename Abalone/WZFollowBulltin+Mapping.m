//
//  WZFollowBulltin+Mapping.m
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZFollowBulltin+Mapping.h"
#import "WZUser+Mapping.h"


@implementation WZFollowBulltin (Mapping)
+(RKManagedObjectMapping *)followBulletinMapping
{
    RKManagedObjectMapping *followBulletinMapping = [RKManagedObjectMapping mappingForClass:[WZFollowBulltin class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    
    followBulletinMapping.primaryKeyAttribute = @"gid";
    [followBulletinMapping mapKeyPathsToAttributes:@"_id",@"gid", nil];
    
    [followBulletinMapping mapAttributes:@"content"
     ,@"createAt",@"postImages",  nil];
    //[followBulletinMapping mapRelationship:@"user" withMapping:[WZUser userMapping]];
    
    return followBulletinMapping;

}
@end
