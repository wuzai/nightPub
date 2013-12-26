//
//  WZHotNews+Networks.h
//  Abalone
//
//  Created by chen  on 13-11-30.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZHotNews.h"
#import "WZNetworkHelper.h"

@interface WZHotNews (Networks)

extern NSString *const WZHotNewsGetSuccessNotification;
extern NSString *const WZHotNewsGetFailedNotification;

+ (BOOL)fetchHotNews;

@end
