//
//  WZMessage+Networks.h
//  Abalone
//
//  Created by 吾在 on 13-4-15.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZMessage.h"
#import "WZNetworkHelper.h"

extern NSString *const WZDownloadMessageSucceedNotification;
extern NSString *const WZDownloadMessageFailedNotification;
extern NSString *const WZSendMessageSucceedNotification ;
extern NSString *const WZSendMessageFailedNotification ;


@class WZUser;
@interface WZMessage (Networks) <WZNetworkBeggar>
+ (BOOL)downloadMessagesForUser:(WZUser *)user;

+(void)sendMessage:(NSString *)str by:(WZUser *)user toUserId:(WZUser *)toUser;
@end
