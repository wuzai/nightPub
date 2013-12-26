//
//  WZStoreListController.m
//  Abalone
//
//  Created by 吾在 on 13-4-3.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZbulletinViewController.h"

#import "WZMerchant.h"
#import "WZMember.h"

#import "WZMember.h"

#import "EGOImageView.h"
#import "WZStore.h"
#import "defines.h"
#import "WZMerchant+Networks.h"
#import "WZLocation.h"
#import "WZStore+serviceItems.h"

#import "WZUser+Me.h"
#import "WZBullietinCell.h"
#import "WZBulletin+Networks.h"
#import "WZCommonsTableViewController.h"
#import "WZBulletinDetailViewController.h"

@interface WZbulletinViewController ()
{
    
}

@end


static NSString *const cellIdentifier = @"bullietinCell";
static NSString *const noCellIdentifier = @"noStoreCell";

@implementation WZbulletinViewController

-(void)addRefreshViewController
{
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(refreshControlEnventValueChanged) forControlEvents:UIControlEventValueChanged];
}

-(void)refreshControlEnventValueChanged
{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中。。。"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchBulletinListSuccess:) name:WZBulletinGetSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchBulletinListFail:) name:WZBulletinGetFailedNotification object:nil];
    
    [WZBulletin fetchBulletin];
}

-(void)fetchBulletinListSuccess:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZBulletinGetSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZBulletinGetFailedNotification object:nil];
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self loadData];
}

-(void)fetchBulletinListFail:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZBulletinGetSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZBulletinGetFailedNotification object:nil];
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRefreshViewController];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    //注册相应UITableViewCell
    NSBundle *classBundle = [NSBundle bundleForClass:[WZBullietinCell class]];
    UINib *cellNib = [UINib nibWithNibName:@"bullietinCell" bundle:classBundle];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:cellIdentifier];
    
//    classBundle = [NSBundle bundleForClass:[WZNoStoreCell class]];
//    cellNib = [UINib nibWithNibName:@"NoStoreCell" bundle:classBundle];
//    [self.tableView registerNib:cellNib forCellReuseIdentifier:noCellIdentifier];
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchBulletinListSuccess:) name:WZBulletinGetSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchBulletinListFail:) name:WZBulletinGetFailedNotification object:nil];
    
    [WZBulletin fetchBulletin];

    [self loadData];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.tableView.window == nil) {
        self.tableView = nil;
    }
}

#pragma mark -
#pragma mark tableview delegate and dataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.bulletinArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (self.bulletinArray.count) {
        WZBulletin *bulletin = [self.bulletinArray objectAtIndex:indexPath.row];
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ([cell isKindOfClass:[WZBullietinCell class]]) {
            WZBullietinCell *bulletinCell = (WZBullietinCell *)cell;
            
            if (bulletin.user.faceIcon)
            {
                bulletinCell.createUserView.imageURL=[NSURL URLWithString:bulletin.user.faceIcon];
            }
            else
            {
                bulletinCell.createUserView.image = [UIImage imageNamed:@"defAvatar.png"];
            }

            
            
            bulletinCell.bullietinTitleLabel.text = bulletin.title;
            bulletinCell.bullietinContentLabel.text = bulletin.content;
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            dateFormatter.dateFormat = @"yyyy-MM-dd";

           NSInteger followCount = bulletin.followBulletins.count;
            
            NSString *followNum = [NSString stringWithFormat:@"回帖数:%i",followCount];
            bulletinCell.followsCountLabel.text = followNum;
            
            bulletinCell.userNameLabel.text = bulletin.user.username;
            NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
            fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            fmt.dateFormat = @"yyyy-MM-dd a HH:mm:ss EEEE";
            NSString* dateString = [fmt stringFromDate:bulletin.createAt];

            
            
            bulletinCell.aaa.text = dateString;
        }
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = ((WZBulletin *)[self.bulletinArray objectAtIndex:indexPath.row]).content;
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:CGSizeMake(100, 999999) lineBreakMode:NSLineBreakByWordWrapping];
       return size.height + 40 > 112? size.height + 40 :112;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.bulletinArray) {
        return;
    }
    if ([self.parentViewController isKindOfClass:[WZCommonsTableViewController class]])
    {
        
        UIStoryboard *storyboard = [UIStoryboard  storyboardWithName:@"abalone" bundle:nil];
        WZBulletinDetailViewController *bulletinDetail = (WZBulletinDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"bulletinDetail"];
        bulletinDetail.bulletin = self.bulletinArray[indexPath.row];
        [self.navigationController pushViewController:bulletinDetail animated:YES];

    }
    
    
}

-(void)loadData
{
    if (!self.bulletinArray) {
        self.bulletinArray = [NSMutableArray array];
    }else{
        [self.bulletinArray removeAllObjects];
    }
  
    NSArray *theBulletins = [WZBulletin allObjects];
    
   if (theBulletins.count) {
        [self.bulletinArray addObjectsFromArray:theBulletins];
        [self sort];
    }else{
        [self.tableView reloadData];
    }
    WZCommonsTableViewController *parent = (WZCommonsTableViewController *)self.parentViewController;
    if (!self.bulletinArray.count) {
        parent.noStoresWarnning.hidden = NO;
        [parent.contentView  bringSubviewToFront:parent.noStoresWarnning];
    }else{
        parent.noStoresWarnning.hidden = YES;
        
    }
}

#pragma mark -

-(void)sort
{
    if (!self.selectedIndex) {
        
        self.selectedIndex = 0;
    }
    if (self.selectedIndex == 0)
    {
        [self sortWithFollow];
        [self.tableView reloadData];

    }
    if (self.selectedIndex == 1) {
        [self sortWithDate];
        [self.tableView reloadData];
    }
}

-(void)sortWithFollow
{
    [self.bulletinArray sortUsingComparator:^(WZBulletin *s1, WZBulletin *s2)
     {
       NSMutableArray *s1FollowBulletinArray =(NSMutableArray *)[s1.followBulletins allObjects ];
         
         NSNumber *s1number = [NSNumber numberWithInteger:s1FollowBulletinArray.count];
         
         NSMutableArray *s2FollowBulletinArray =(NSMutableArray *)[s2.followBulletins allObjects ];
         
         NSNumber *s2number = [NSNumber numberWithInteger:s2FollowBulletinArray.count];
         
         return [s2number compare:s1number];
     }];
}


-(void)sortWithDate
{
    [self.bulletinArray sortUsingComparator:^(WZBulletin *s1, WZBulletin *s2)
    {
        return [s2.createAt compare:s1.createAt];
    }];
}

@end



















