//
//  WZSendMessageViewController.h
//  Abalone
//
//  Created by chen  on 13-12-23.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZUser.h"

@interface WZSendMessageViewController:UIViewController <UITextViewDelegate>
- (IBAction)sendMessage:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UILabel *wordNum;
@property (nonatomic,strong) WZUser *toUser;
@end
