//
//  WZMessage.h
//  Abalone
//
//  Created by chen  on 13-12-23.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZUser;

@interface WZMessage : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSDate * sentTime;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSString * toUserId;
@property (nonatomic, retain) WZUser *send;

@end
