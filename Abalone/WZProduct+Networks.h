//
//  WZProduct+Networks.h
//  Abalone
//
//  Created by chen  on 13-12-3.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZProduct.h"
#import "WZNetworkHelper.h"


extern NSString *const WZProductsGetSuccessNotification;
extern NSString *const WZProductsGetFailedNotification;
@interface WZProduct (Networks)
+ (BOOL)fetchProducts:(NSString *)merchantId;
@end
