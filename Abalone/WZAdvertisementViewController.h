//
//  WZAdvertisementViewController.h
//  Abalone
//
//  Created by 吾在 on 13-4-27.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZAd;
@interface WZAdvertisementViewController : UIViewController
@property (nonatomic) WZAd *advertisement;
@property (strong, nonatomic) IBOutlet UILabel *adTitle;

@property (weak, nonatomic) IBOutlet UILabel *merchantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
