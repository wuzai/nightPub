//
//  WZCommentCell.h
//  Abalone
//
//  Created by 吾在 on 13-4-25.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *cellbackgroundView;
@property (weak, nonatomic) IBOutlet EGOImageView *userIconView;

@end
