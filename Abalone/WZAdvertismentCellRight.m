//
//  WZAdvertismentCellRight.m
//  Abalone
//
//  Created by chen  on 13-11-21.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZAdvertismentCellRight.h"

@implementation WZAdvertismentCellRight

@synthesize logoView = _logoView;
@synthesize titleLabel = _titleLabel;
@synthesize merchantLabel = _merchantLabel;
@synthesize backgroundImageView = _backgroundImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
