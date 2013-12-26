//
//  WZUserInfosViewController.h
//  Abalone
//
//  Created by chen  on 13-12-19.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZUser+Me.h"
#import "EGOImageView.h"

@interface WZUserInfosViewController : UITableViewController
@property (strong,nonatomic) WZUser *user;
@property (weak, nonatomic) IBOutlet EGOImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UILabel *otherName;
@property (weak, nonatomic) IBOutlet EGOImageView *picture1View;
@property (weak, nonatomic) IBOutlet EGOImageView *picture2View;
@property (weak, nonatomic) IBOutlet EGOImageView *picture3View;

@end
