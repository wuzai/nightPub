//
//  WZHotOneNewsCell.h
//  Abalone
//
//  Created by chen  on 13-11-29.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface WZHotOneNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsContent;

@property (weak, nonatomic) IBOutlet EGOImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
