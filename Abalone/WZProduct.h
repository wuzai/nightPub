//
//  WZProduct.h
//  Abalone
//
//  Created by chen  on 13-12-3.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WZMerchant;

@interface WZProduct : NSManagedObject

@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * intrl;
@property (nonatomic, retain) NSString * originalPrice;
@property (nonatomic, retain) NSString * privilegePrice;
@property (nonatomic, retain) NSString * postImage;
@property (nonatomic, retain) NSString * merchantId;
@property (nonatomic, retain) WZMerchant *merchant;

@end
