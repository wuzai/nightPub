//
//  WZMerchant+Mapping.m
//  Abalone
//
//  Created by 吾在 on 13-4-11.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMerchant+Mapping.h"
#import "WZServiceItem+Mapping.h"
#import "WZComment+Mapping.h"
#import "WZProduct+mapping.h"
#import "WZLocation+Mapping.h"

@implementation WZMerchant (Mapping)
+(RKObjectMapping *)merchntMapping
{
    
    RKManagedObjectMapping *merchantMapping = [RKManagedObjectMapping mappingForClass:[WZMerchant class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
   merchantMapping.primaryKeyAttribute = @"gid";
    [merchantMapping mapKeyPathsToAttributes:@"_id",@"gid",
    @"createdAt",@"createTime",
    @"updateAt",@"updateTime",
    @"merchantName",@"name",
    @"logoUrl",@"logo",
    @"webSite",@"url",
    @"intro",@"intro",
    @"customerServicePhone",@"telphone",
     @"memberNum",@"memberNumber",
     @"postUrl",@"image",
     @"merchantType",@"merchatType",
     @"description",@"desc",
     
     @"point",@"score",nil];
    
    
    [merchantMapping mapAttributes:@"address",@"email",@"coordinate",@"explain",@"scoreState",@"comment",@"rate",@"rateExplain",@"largessExplain", nil];
    
//    [merchantMapping  mapRelationship:@"stores" withMapping:[WZStore storeMapping]];
    [merchantMapping  mapRelationship:@"products" withMapping:[WZProduct productMapping]];

    [merchantMapping mapRelationship:@"serviceItems" withMapping:[WZServiceItem serviceItemMapping]];
    [merchantMapping mapRelationship:@"comments" withMapping:[WZComment commentMapping]];
    
    [merchantMapping mapRelationship:@"location" withMapping:[WZLocation locationMapping]];
    
    return merchantMapping;
}
@end
