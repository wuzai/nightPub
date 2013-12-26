//
//  WZMorePicCell.h
//  Abalone
//
//  Created by chen  on 13-12-2.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZMorePicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet EGOImageView *firstPic;
@property (weak, nonatomic) IBOutlet EGOImageView *secPic;
@property (weak, nonatomic) IBOutlet EGOImageView *lastPic;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
