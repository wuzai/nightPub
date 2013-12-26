//
//  WZProduct+mapping.h
//  Abalone
//
//  Created by chen  on 13-12-3.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZProduct.h"

#import <RestKit/RestKit.h>
@interface WZProduct (mapping)
+(RKManagedObjectMapping *) productMapping;
@end
