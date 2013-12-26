//
//  WZUserInfoViewController.h
//  Abalone
//
//  Created by chen  on 13-12-19.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "WZUser.h"

@interface WZUserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet EGOImageView *pic1View;
@property (weak, nonatomic) IBOutlet EGOImageView *pic2View;
@property (weak, nonatomic) IBOutlet EGOImageView *pic3View;
@property (weak, nonatomic) IBOutlet EGOImageView *user1View;
@property (weak, nonatomic) IBOutlet EGOImageView *user2View;
@property (weak, nonatomic) IBOutlet EGOImageView *user3View;
@property (strong,nonatomic) IBOutlet WZUser *user;
@property (weak, nonatomic) IBOutlet UILabel *otherName;
@property (weak, nonatomic) IBOutlet EGOImageView *faceView;

@end
