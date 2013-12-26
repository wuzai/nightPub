//
//  WZbulletinViewController.h
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WZbulletinViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *bulletinArray;
@property (nonatomic,strong) NSArray *comparator;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,strong) CLLocation *here;

@property (nonatomic,assign)NSInteger items;
-(void)sort;
-(void)loadData;
@end
