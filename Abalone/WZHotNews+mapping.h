//
//  WZHotNews+mapping.h
//  Abalone
//
//  Created by chen  on 13-11-29.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZHotNews.h"

#import <RestKit/RestKit.h>

@interface WZHotNews (mapping)
+(RKManagedObjectMapping *)hotNewsMapping;
@end
