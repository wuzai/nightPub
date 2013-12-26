//
//  WZStoreDetailInfoViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-22.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZStoreDetailInfoViewController.h"
#import "WZMerchant.h"
#import "WZStoreDetailViewController.h"

@interface WZStoreDetailInfoViewController ()

@end

@implementation WZStoreDetailInfoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)updateViews
{
    self.storeAddressTextView.text = self.merchant.name;
    self.storeCellPhoneLabel.text = self.merchant.telphone;
    self.merchantIntro.text = self.merchant.intro;
    self.webURL.text = self.merchant.url;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window) {
       
    }
}



#pragma mark - 
#pragma mark UITableViewDelegate and UITableViewDataSource Methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 44;
    }else if(indexPath.section == 0 && indexPath.row ==1){
        CGSize size = [self.storeAddressTextView.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.storeAddressTextView.frame.size.width, 9999999) lineBreakMode:NSLineBreakByWordWrapping];
        return  44;
    }else if(indexPath.section == 0 && indexPath.row == 2){
        CGSize size = [self.merchantIntro.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.merchantIntro.frame.size.width, 9999999) lineBreakMode:NSLineBreakByWordWrapping];
         return size.height + 12 > 240 ? size.height + 12 : 240;
    }
    
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 2) {
        [self.parentViewController performSegueWithIdentifier:@"showOtherStores" sender:nil];
    }else if(indexPath.row == 1 &&indexPath.section == 0){
        [self.parentViewController performSegueWithIdentifier:@"showMap" sender:nil];
    }else if(indexPath.row == 0 && indexPath.section == 0){
        if (self.merchant.telphone )
        {
            NSString *message = [NSString stringWithFormat:@"您确定拨打 %@ 吗？",self.merchant.telphone];
            UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 44, 300, 100)];
            messageLabel.text = message;
            messageLabel.numberOfLines = 0;
            messageLabel.backgroundColor = [UIColor clearColor];
            messageLabel.textColor = [UIColor redColor];
            messageLabel.textAlignment = NSTextAlignmentCenter;
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提示\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [actionSheet addSubview:messageLabel];
            [actionSheet showFromTabBar:self.tabBarController.tabBar];
        }
    }else if(indexPath.section == 0 && indexPath.row == 2  ){
        if (self.merchant.url.length) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.merchant.url]]];
        }
    
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.merchant.telphone]]];
    }
}


- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
       return nil;
}
@end















