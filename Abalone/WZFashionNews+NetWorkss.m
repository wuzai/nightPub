//
//  WZFashionNews+NetWorkss.m
//  Abalone
//
//  Created by chen  on 13-11-30.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZFashionNews+NetWorkss.h"
#import "RKObjectMapping+Null.h"
#import "RKObjectLoader+Scheme.h"
#import "WZFashionNews+Mapping.h"

 NSString *const WZFashionNewsGetSuccessNotification = @"WZFashionNewsGetSuccessNotification";
NSString *const WZFashionNewsGetFailedNotification=
@"WZFashionNewsGetFailedNotification";


@implementation WZFashionNews (NetWorkss)

+(RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"newsType", nil];
    return mapping;
}

+ (BOOL)fetchFashionNews
{
    NSDictionary *dic = @{@"newsType":@"fashionNews"};
    return [[WZNetworkHelper helper] help:[self class] with:@{@"newsType":@"fashionNews"} object:nil by:RKRequestMethodGET];
   
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
            return [[self class] fashionNewsMapping ];
        default:
            break;
    }
    return nil;
}



#pragma mark - CallBacks

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WZFashionNewsGetSuccessNotification  object:results]; //添加对返回值的处理
        
    }
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WZFashionNewsGetFailedNotification  object:error];
        
    }
}


@end
