//
//  WZCommonsTableViewController.h
//  Abalone
//
//  Created by chen  on 13-11-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZMultiImageView.h"
#import "WZbulletinViewController.h"
#import "SDSegmentedControl.h"

@interface WZCommonsTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet SDSegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *noStoresWarnning;
@property (strong,nonatomic) IBOutlet WZbulletinViewController *listViewController;
- (IBAction)createBulletin:(id)sender;
- (IBAction)sort:(id)sender;
- (IBAction)segValueChange:(id)sender;

@end




