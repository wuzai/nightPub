//
//  WZFollowBulltin.h
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZBulletin, WZUser;

@interface WZFollowBulltin : NSManagedObject

@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSDate * createAt;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * bullteinId;
@property (nonatomic, retain) NSString * postImages;
@property (nonatomic, retain) WZBulletin *bulletin;
@property (nonatomic, retain) WZUser *user;

@end
