//
//  WZHotNews.h
//  Abalone
//
//  Created by chen  on 13-12-2.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WZHotNews : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * gid;
@property (nonatomic, retain) NSString * newsType;
@property (nonatomic, retain) NSString * postImage;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * subhead;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * createAt;

@end
