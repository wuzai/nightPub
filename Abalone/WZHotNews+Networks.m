//
//  WZHotNews+Networks.m
//  Abalone
//
//  Created by chen  on 13-11-30.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZHotNews+Networks.h"
#import "RKObjectMapping+Null.h"
#import "RKObjectLoader+Scheme.h"
#import "WZHotNews+mapping.h"

 NSString *const WZHotNewsGetSuccessNotification=@"WZHotNewsGetSuccessNotification";
 NSString *const WZHotNewsGetFailedNotification=@"WZHotNewsGetFailedNotification";

@implementation WZHotNews (Networks)


+(RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"newsType", nil];
    return mapping;
}

+ (BOOL)fetchHotNews
{
    NSDictionary *dic = @{@"newsType":@"hotNews"};
    return [[WZNetworkHelper helper] help:[self class] with:@{@"newsType":@"hotNews"}  object:nil by:RKRequestMethodGET];
    
}

#pragma mark - Protocol
+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"newsInfos";
}

+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    switch (method) {
        case RKRequestMethodPUT:
            return [RKObjectMapping nullMapping];
            break;
        case RKRequestMethodGET:
            return [[self class] hotNewsMapping ];
         default:
            break;
    }
    return nil;
}



#pragma mark - CallBacks

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WZHotNewsGetSuccessNotification  object:results]; //添加对返回值的处理
        
    }
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WZHotNewsGetFailedNotification  object:error];
        
    }
}


@end
