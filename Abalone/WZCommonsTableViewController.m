//
//  WZCommonsTableViewController.m
//  Abalone
//
//  Created by chen  on 13-11-26.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZCommonsTableViewController.h"
#import "WZTextCell.h"
#import "WZMultiImageView.h"
#import "WZbulletinViewController.h"
#import "WZBulletinDetailViewController.h"
#import "WZCreateBulletinViewController.h"
#import "WZUser+Me.h"


@interface WZCommonsTableViewController ()

@end

@implementation WZCommonsTableViewController
@synthesize segmentControl = _segmentControl;
@synthesize noStoresWarnning =_noStoresWarnning;
@synthesize listViewController=_listViewController;
@synthesize contentView=_contentView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.listViewController) {
        
        self.listViewController = [WZbulletinViewController new];
        [self addChildViewController:self.listViewController];
        CGRect frame =  self.listViewController.tableView.frame;
        frame.origin.y = 45;
        frame.size.height = self.contentView.frame.size.height - 44;
        self.listViewController.tableView.frame = frame;
      
        
        [self.contentView addSubview:self.listViewController.tableView];
        self.listViewController.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.listViewController didMoveToParentViewController:self];
    }
    self.segmentControl.viewForBaselineLayout.backgroundColor=[UIColor blackColor];
    
    
    self.contentView.clipsToBounds = NO;
    [self.contentView addSubview:_listViewController.tableView];
    [self addChildViewController:_listViewController];

    _listViewController.tableView. autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    [_listViewController didMoveToParentViewController:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([@"showbulletinDetail" isEqualToString:segue.identifier]) {
        if ([segue.destinationViewController isKindOfClass:[WZBulletinDetailViewController class]]) {
            WZBulletinDetailViewController *followBulletinDetail = (WZBulletinDetailViewController *)segue.destinationViewController;
            followBulletinDetail.bulletin = sender;
        }
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)createBulletin:(id)sender {
    if (![WZUser me])
    {
        [self performSegueWithIdentifier:@"Login" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"createBulletin" sender:nil];
    }
}

- (IBAction)sort:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *control = (UISegmentedControl *)sender;
        
            self.listViewController.selectedIndex = control.selectedSegmentIndex;
        [self.listViewController sort];
        
    }
}

- (IBAction)segValueChange:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *control = (UISegmentedControl *)sender;
        
        self.listViewController.selectedIndex = control.selectedSegmentIndex;
        [self.listViewController sort];
        
    }
}
@end
