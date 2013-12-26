//
//  WZBullietinCell.h
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZBullietinCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *followsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bullietinTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bullietinContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *aaa;
@property (weak, nonatomic) IBOutlet EGOImageView *createUserView;

@end
