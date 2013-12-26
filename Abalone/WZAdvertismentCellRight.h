//
//  WZAdvertismentCellRight.h
//  Abalone
//
//  Created by chen  on 13-11-21.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZAdvertismentCellRight : UITableViewCell
@property (nonatomic,weak) IBOutlet EGOImageView *logoView;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *merchantLabel;
@property (nonatomic,weak) IBOutlet UIImageView *backgroundImageView;
@end
