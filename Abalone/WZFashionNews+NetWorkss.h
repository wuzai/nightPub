//
//  WZFashionNews+NetWorkss.h
//  Abalone
//
//  Created by chen  on 13-11-30.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZFashionNews.h"
#import "WZNetworkHelper.h"

@interface WZFashionNews (NetWorkss)
extern NSString *const WZFashionNewsGetSuccessNotification;
extern NSString *const WZFashionNewsGetFailedNotification;

+ (BOOL)fetchFashionNews;
@end
