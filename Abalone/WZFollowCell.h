//
//  WZFollowCell.h
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZFollowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *followContent;
@property (weak, nonatomic) IBOutlet UILabel *followDate;
@property (weak, nonatomic) IBOutlet UILabel *contentText;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet EGOImageView *faceIconView;

@end
