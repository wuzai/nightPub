//
//  WZUserProfileViewController.h
//  MyCard
//
//  Created by 吾在 on 13-3-20.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZGenderSwitch.h"
#import "EGOImageView.h"


@interface WZUserProfileViewController  :UIViewController<UIActionSheetDelegate,
UIImagePickerControllerDelegate>
{
    UIImagePickerController* pickerController;
    UIImage *avatarImage;
}
@property (nonatomic, weak) IBOutlet UILabel *userLabel;
@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *otherName;

@property (strong,nonatomic) IBOutlet UITextField *realName;
@property (weak, nonatomic) IBOutlet EGOImageView *faceImageView;
- (IBAction)goPicView:(id)sender;


- (IBAction)changeFaceIcon:(id)sender;

@property (nonatomic, weak) IBOutlet WZGenderSwitch *genderSwitch;
@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UIButton *birthButton;
- (IBAction)logout:(id)sender;
- (IBAction)update:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)birthday:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *spaceButton;
- (IBAction)mySpaceAction:(id)sender;

@end
