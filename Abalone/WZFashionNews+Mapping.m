//
//  WZFashionNews+Mapping.m
//  Abalone
//
//  Created by chen  on 13-11-29.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZFashionNews+Mapping.h"


@implementation WZFashionNews (Mapping)
+(RKManagedObjectMapping *) fashionNewsMapping
{
    RKManagedObjectMapping *followBulletinMapping = [RKManagedObjectMapping mappingForClass:[WZFashionNews class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    
    followBulletinMapping.primaryKeyAttribute = @"gid";
    [followBulletinMapping mapKeyPathsToAttributes:@"_id",@"gid", nil];
    
    [followBulletinMapping mapAttributes:@"title",@"subhead",@"content",@"source"
     ,@"createAt",@"postImage",  nil];
    return followBulletinMapping;

}

@end
