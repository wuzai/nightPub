//
//  WZBulletin+Mapping.h
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZBulletin.h"
#import <RestKit/RestKit.h>

@interface WZBulletin (Mapping)
+(RKManagedObjectMapping *)bulletinMapping;
@end
