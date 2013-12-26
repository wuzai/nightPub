//
//  WZAddFollowBulletinViewController.h
//  Abalone
//
//  Created by chen  on 13-11-28.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZBulletin.h"

@interface WZAddFollowBulletinViewController : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (strong,nonatomic)  WZBulletin *bulletin;

- (IBAction)sendFollowBulletin:(id)sender;

@end
