//
//  WZHotNews+mapping.m
//  Abalone
//
//  Created by chen  on 13-11-29.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZHotNews+mapping.h"

@implementation WZHotNews (mapping)

+(RKManagedObjectMapping *)hotNewsMapping
{
    RKManagedObjectMapping *followBulletinMapping = [RKManagedObjectMapping mappingForClass:[WZHotNews class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    
    followBulletinMapping.primaryKeyAttribute = @"gid";
    [followBulletinMapping mapKeyPathsToAttributes:@"_id",@"gid", nil];
    
    [followBulletinMapping mapAttributes:@"title",@"subhead",@"content",@"source"
     ,@"createAt",@"postImage",  nil];
    return followBulletinMapping;

}
@end
