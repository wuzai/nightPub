//
//  WZFollowBulltin+Networks.h
//  Abalone
//
//  Created by chen  on 13-11-28.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZFollowBulltin.h"
#import "WZBulletin.h"
#import "WZNetworkHelper.h"
#import "WZUser+Me.h"

@interface WZFollowBulltin (Networks)
extern NSString *const WZFollowBulletinAddSuccessNotification;
extern NSString *const WZFollowBulletinAddFailedNotification;
+ (void)addFollowBulletin:(NSString *)content by:(WZUser *)user forBulletinId:(NSString *)bulletinId;

@end
