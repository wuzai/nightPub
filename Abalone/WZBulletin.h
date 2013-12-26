//
//  WZBulletin.h
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZUser;

@interface WZBulletin : NSManagedObject

@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSDate * createAt;
@property (nonatomic, retain) NSString * postImages;
@property (nonatomic, retain) WZUser *user;
@property (nonatomic, retain) NSSet *followBulletins;
@end

@interface WZBulletin (CoreDataGeneratedAccessors)

- (void)addFollowBulletinsObject:(NSManagedObject *)value;
- (void)removeFollowBulletinsObject:(NSManagedObject *)value;
- (void)addFollowBulletins:(NSSet *)values;
- (void)removeFollowBulletins:(NSSet *)values;

@end
