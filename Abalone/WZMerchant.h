//
//  WZMerchant.h
//  Abalone
//
//  Created by chen  on 13-12-10.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZAd, WZComment, WZLocation, WZMember, WZMessage, WZPointRecord, WZProduct, WZServiceItem, WZStore;

@interface WZMerchant : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * coordinate;
@property (nonatomic, retain) NSString * createTime;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * explain;
@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * intro;
@property (nonatomic, retain) NSString * largessExplain;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSNumber * memberNumber;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * parentID;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) NSString * rateExplain;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSString * scorestate;
@property (nonatomic, retain) NSString * telphone;
@property (nonatomic, retain) NSDate * updateTime;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * merchatType;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSSet *ads;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *members;
@property (nonatomic, retain) NSSet *messages;
@property (nonatomic, retain) NSSet *pointRecords;
@property (nonatomic, retain) NSSet *products;
@property (nonatomic, retain) NSSet *serviceItems;
@property (nonatomic, retain) NSSet *stores;
@property (nonatomic, retain) WZLocation *location;
@end

@interface WZMerchant (CoreDataGeneratedAccessors)

- (void)addAdsObject:(WZAd *)value;
- (void)removeAdsObject:(WZAd *)value;
- (void)addAds:(NSSet *)values;
- (void)removeAds:(NSSet *)values;

- (void)addCommentsObject:(WZComment *)value;
- (void)removeCommentsObject:(WZComment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addMembersObject:(WZMember *)value;
- (void)removeMembersObject:(WZMember *)value;
- (void)addMembers:(NSSet *)values;
- (void)removeMembers:(NSSet *)values;

- (void)addMessagesObject:(WZMessage *)value;
- (void)removeMessagesObject:(WZMessage *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

- (void)addPointRecordsObject:(WZPointRecord *)value;
- (void)removePointRecordsObject:(WZPointRecord *)value;
- (void)addPointRecords:(NSSet *)values;
- (void)removePointRecords:(NSSet *)values;

- (void)addProductsObject:(WZProduct *)value;
- (void)removeProductsObject:(WZProduct *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

- (void)addServiceItemsObject:(WZServiceItem *)value;
- (void)removeServiceItemsObject:(WZServiceItem *)value;
- (void)addServiceItems:(NSSet *)values;
- (void)removeServiceItems:(NSSet *)values;

- (void)addStoresObject:(WZStore *)value;
- (void)removeStoresObject:(WZStore *)value;
- (void)addStores:(NSSet *)values;
- (void)removeStores:(NSSet *)values;

@end
