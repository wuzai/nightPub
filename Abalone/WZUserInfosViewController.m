//
//  WZUserInfosViewController.m
//  Abalone
//
//  Created by chen  on 13-12-19.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//
#import "WZSendMessageViewController.h"
#import "WZUserInfosViewController.h"

@interface WZUserInfosViewController ()

@end

@implementation WZUserInfosViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.user)
    {
        self.otherName.text = self.user.username;
        self.faceImageView.imageURL = [NSURL URLWithString:self.user.faceIcon];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3 && indexPath.section ==0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"abalone" bundle:nil];
        WZSendMessageViewController *infoViewControll = (WZSendMessageViewController *)[sb instantiateViewControllerWithIdentifier:@"sendMessage"];
           infoViewControll.toUser = self.user;
        [self.navigationController pushViewController:infoViewControll animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
