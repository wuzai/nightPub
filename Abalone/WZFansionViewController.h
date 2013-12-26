//
//  WZFansionViewController.h
//  Abalone
//
//  Created by chen  on 13-11-29.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZMultiImageView.h"
#import "WZFansionListViewController.h"
#import "SDSegmentedControl.h"

@interface WZFansionViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *noStoresWarnning;
@property (strong,nonatomic) IBOutlet WZFansionListViewController *listViewController;
@end
