//
//  WZProduct+Networks.m
//  Abalone
//
//  Created by chen  on 13-12-3.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZProduct+Networks.h"
#import "RKObjectMapping+Null.h"
#import "RKObjectLoader+Scheme.h"
#import "WZProduct+mapping.m"


NSString *const WZProductsGetSuccessNotification=@"WZProductsGetSuccessNotification";
NSString *const WZProductsGetFailedNotification=@"WZProductsGetFailedNotification";

@implementation WZProduct (Networks)


+ (RKObjectMapping *)objectMappingForMethod:(RKRequestMethod)method
{
    switch (method) {
        case RKRequestMethodPUT:
            return [RKObjectMapping nullMapping];
            break;
        case RKRequestMethodGET:
            return [[self class] productMapping ];
        default:
            break;
    }
    return nil;
}


+(RKObjectMapping *)sourceMappingForMethod:(RKRequestMethod)method
{
    RKObjectMapping *mapping = [RKObjectMapping serializationMapping];
    [mapping mapAttributes:@"merchantId", nil];
    return mapping;
}

#pragma mark - Protocol
+ (RKObjectManager *)manager
{
    return [RKObjectManager sharedManager];
}

+ (NSString *)resoucePath
{
    return @"products";
}


+ (BOOL)fetchProducts:(NSString *)merchantId
{
    return [[WZNetworkHelper helper] help:[self class] with:@{@"merchantId":merchantId}  object:nil by:RKRequestMethodGET];

}


#pragma mark - CallBacks

+ (void)succeedIn:(RKObjectLoader *)loader withResults:(NSArray *)results
{
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WZProductsGetSuccessNotification  object:results]; //添加对返回值的处理
        
    }
}

+ (void)failedIn:(RKObjectLoader *)loader withError:(NSError *)error
{
    
    if ([loader.route isEqualToString:[[self class] resoucePath]] && loader.method == RKRequestMethodGET) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WZProductsGetSuccessNotification  object:error];
        
    }
}


@end
