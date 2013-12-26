//
//  WZHotNewsViewController.h
//  Abalone
//
//  Created by chen  on 13-11-29.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZMultiImageView.h"
#import "SDSegmentedControl.h"
#import "WZHotNewsListViewController.h"

@interface WZHotNewsViewController : UIViewController

@property (weak, nonatomic) IBOutlet SDSegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *noStoresWarnning;
@property (weak, nonatomic) IBOutlet UILabel *todayDateLabel;


@property (strong,nonatomic) IBOutlet WZHotNewsListViewController *listViewController;
@end
