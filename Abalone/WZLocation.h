//
//  WZLocation.h
//  Abalone
//
//  Created by chen  on 13-12-10.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZMerchant, WZStore;

@interface WZLocation : NSManagedObject

@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * relevantText;
@property (nonatomic, retain) WZStore *store;
@property (nonatomic, retain) WZMerchant *merchant;

@end
