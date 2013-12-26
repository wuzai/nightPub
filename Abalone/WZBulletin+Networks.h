//
//  WZBulletin+Networks.h
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZBulletin.h"
#import "WZNetworkHelper.h"
#import "WZUser+Me.h"

extern NSString *const WZBulletinGetSucceedNotification;
extern NSString *const WZBulletinGetFailedNotification;
extern NSString *const WZBulletinAddSuccessNotification;
extern NSString *const WZBulletinAddFailedNotification;


@interface WZBulletin (Networks)<WZNetworkBeggar>


+ (BOOL)fetchBulletin;

+(void)createBulletin:(NSString *)content with:(NSString *)title by:(WZUser *)user;

@end
