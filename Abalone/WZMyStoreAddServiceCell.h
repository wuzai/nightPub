//
//  WZMyStoreAddServiceCell.h
//  Abalone
//
//  Created by 吾在 on 13-5-6.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface WZMyStoreAddServiceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet EGOImageView *storeServiceImage;
@property (weak, nonatomic) IBOutlet UILabel *storeServiceName;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *meteringCardNum;
@property (weak, nonatomic) IBOutlet UIImageView *meteringCardNumImage;



@end
