//
//  WZShowServiceItemDetailViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZProduct.h"
#import "UITextView+Zoom.h"
#import "EGOImageView.h"
#import "WZStore.h"

@interface WZShowServiceItemDetailViewController : UITableViewController
@property (nonatomic,strong) WZProduct *serviceItem;
@property (nonatomic,strong) WZMerchant *merchant;
@property (weak, nonatomic) IBOutlet EGOImageView *serviceItemImageView;
@property (weak, nonatomic) IBOutlet UILabel *serviceItemDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceItemconditionsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addressbackImageView;

@property (weak, nonatomic) IBOutlet UILabel *serviceItemTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *ServiceItemapplyButton;
- (IBAction)applyServiceItem:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *serviceItemContentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *contentbackImageView;

@property (weak, nonatomic) IBOutlet UILabel *serviceItemAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *serviceItemNameLabel;

@property (weak, nonatomic) IBOutlet UITableViewCell *serviceItemHeaderCell;
@property (weak, nonatomic) IBOutlet UIView *contentView;


@property (weak, nonatomic) IBOutlet UILabel *serviceItemRule;
@property (weak, nonatomic) IBOutlet UIImageView *serviceItemRulebackImageView;

@end
