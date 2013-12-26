//
//  WZCreateBulletinViewController.h
//  Abalone
//
//  Created by chen  on 13-11-28.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZCreateBulletinViewController : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *textCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleCountLabel;

- (IBAction)createBulletin:(id)sender;
@end
