//
//  WZHotNewsViewController.m
//  Abalone
//
//  Created by chen  on 13-11-29.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZHotNewsViewController.h"
#import "WZHotNewsListViewController.h"

@interface WZHotNewsViewController ()

@end

@implementation WZHotNewsViewController

@synthesize noStoresWarnning =_noStoresWarnning;
@synthesize listViewController=_listViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.listViewController) {
        
        self.listViewController = [WZHotNewsListViewController new];
        [self addChildViewController:self.listViewController];
        CGRect frame =  self.listViewController.tableView.frame;
        frame.origin.y = 28;
        frame.size.height = self.contentView.frame.size.height - 28;
        self.listViewController.tableView.frame = frame;
        [self.listViewController.tableView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.listViewController.tableView];
        self.listViewController.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.listViewController didMoveToParentViewController:self];
    }
    
    NSDate *date = [NSDate new];
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    [dateFormater setDateFormat:@"yyyy年MM月dd日  HH时mm分"];
    NSString *dateStr = [dateFormater stringFromDate:date];
    self.todayDateLabel.text = dateStr;

    
    
    self.contentView.clipsToBounds = NO;
    [self.contentView addSubview:_listViewController.tableView];
    [self addChildViewController:_listViewController];
    
    _listViewController.tableView. autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    [_listViewController didMoveToParentViewController:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([@"showNewsDetail" isEqualToString:segue.identifier]) {
//        if ([segue.destinationViewController isKindOfClass:[WZBulletinDetailViewController class]]) {
//            WZBulletinDetailViewController *followBulletinDetail = (WZBulletinDetailViewController *)segue.destinationViewController;
//            followBulletinDetail.bulletin = sender;
//        }
    }
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
