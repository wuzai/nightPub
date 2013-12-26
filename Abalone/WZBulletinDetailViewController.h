//
//  WZBulletinDetailViewController.h
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZBulletin.h"
#import "EGOImageView.h"

@interface WZBulletinDetailViewController : UITableViewController
@property (nonatomic,strong) IBOutlet WZBulletin *bulletin;


@property (nonatomic,strong) IBOutlet NSMutableArray *followBulletinArray;
@end
