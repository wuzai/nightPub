//
//  WZProduct+mapping.m
//  Abalone
//
//  Created by chen  on 13-12-3.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZProduct+mapping.h"

@implementation WZProduct (mapping)

+ (RKObjectMapping *)productMapping
{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:[self class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    [mapping mapKeyPath:@"title" toAttribute:@"name"];
    [mapping mapKeyPath:@"intro" toAttribute:@"intrl"];
       [mapping mapKeyPath:@"imageView" toAttribute:@"postImage"];
    [mapping mapAttributes:@"merchantId",@"originalPrice",@"privilegePrice",
    
     nil];
    
    [mapping mapKeyPath:@"_id" toAttribute:@"gid"];
    mapping.primaryKeyAttribute = @"gid";
    
    return mapping;
}

@end
