//
//  WZUserListCell.h
//  Abalone
//
//  Created by chen  on 13-11-21.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZUserListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet EGOImageView *faceIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet EGOImageView *faceIconView;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end


