//
//  WZFansionListViewController.m
//  Abalone
//
//  Created by chen  on 13-11-29.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZFansionListViewController.h"
#import "WZFansionNewsWebViewController.h"

@interface WZFansionListViewController ()

@end
//
//  WZHotNewsListViewController.m
//  Abalone
//
//  Created by chen  on 13-11-29.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZHotNewsListViewController.h"
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
#import "WZHotOneNewsCell.h"
#import "WZHotNewsNoPicCell.h"
#import "WZMorePicCell.h"
#import "WZFashionNews+Networkss.h"
#import "WZFansionViewController.h"

@interface WZFansionListViewController ()

@end


static NSString *const cellIdentifier = @"onePicNewsCell";
static NSString *const noCellIdentifier = @"noPicNewsCell";
static NSString *const morePicCellIdentifier = @"morePicNewsCell";

@implementation WZFansionListViewController

-(void)addRefreshViewController
{
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(refreshControlEnventValueChanged) forControlEvents:UIControlEventValueChanged];
}

-(void)refreshControlEnventValueChanged
{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中。。。"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchFashionNewsListSuccess:) name:WZFashionNewsGetSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchFashionNewsListFail:) name:WZFashionNewsGetFailedNotification object:nil];
    
    [WZFashionNews fetchFashionNews];
}

-(void)fetchFashionNewsListSuccess:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZFashionNewsGetSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZFashionNewsGetFailedNotification object:nil];
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self loadData];
}

-(void)fetchFashionNewsListFail:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZFashionNewsGetSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZFashionNewsGetFailedNotification object:nil];
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
    NSBundle *classBundle = [NSBundle bundleForClass:[WZHotOneNewsCell class]];
    UINib *cellNib = [UINib nibWithNibName:@"HotNewsNoPicView" bundle:classBundle];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:noCellIdentifier];
    
    classBundle = [NSBundle bundleForClass:[WZHotNewsNoPicCell class]];
    cellNib = [UINib nibWithNibName:@"hotNewsView" bundle:classBundle];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:cellIdentifier];
    
    
    classBundle = [NSBundle bundleForClass:[WZMorePicCell class]];
    cellNib = [UINib nibWithNibName:@"morePicView" bundle:classBundle];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:morePicCellIdentifier];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchFashionNewsListSuccess:) name:WZFashionNewsGetSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchFashionNewsListFail:) name:WZFashionNewsGetFailedNotification object:nil];
    
    [WZFashionNews fetchFashionNews];
    
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
    
    return [self.fansionNewsArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (self.fansionNewsArray.count) {
        WZFashionNews *news = [self.fansionNewsArray objectAtIndex:indexPath.row];
        
        
        NSArray *chunks = [news.postImage componentsSeparatedByString: @","];
        
        if ([news.postImage isEqualToString: @""])
        {
            cell = [self.tableView dequeueReusableCellWithIdentifier:noCellIdentifier];
            WZHotNewsNoPicCell *newsCell = (WZHotNewsNoPicCell *)cell;
            newsCell.newsTitle.text = news.title;
            newsCell.newsContent.text = news.content;
            
        }
        else {
            if (chunks.count == 1 )//|| chunks.count == 2)
            {
                cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                WZHotOneNewsCell *newsCell = (WZHotOneNewsCell *)cell;
                newsCell.newsTitle.text = news.title;
                newsCell.newsContent.text = news.content;
                
                newsCell.postImageView.imageURL = [NSURL URLWithString:chunks[0]];
            }
            else
            {
                cell = [self.tableView dequeueReusableCellWithIdentifier:morePicCellIdentifier];
                WZMorePicCell *newsCell = (WZMorePicCell *)cell;
                newsCell.titleLabel.text = news.title;
                newsCell.contentLabel.text = news.content;
                newsCell.firstPic.imageURL = [NSURL URLWithString:chunks[0]];
                newsCell.secPic.imageURL = [NSURL URLWithString:chunks[1]];
                //            newsCell.lastPic.imageURL = [NSURL URLWithString:chunks[2]];
            }
        }
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.fansionNewsArray.count) {
        WZFashionNews *news = [self.fansionNewsArray objectAtIndex:indexPath.row];
        if ([news.postImage isEqualToString: @""])
        {
            return 110;
        }
        else
        {
            NSArray *chunks = [news.postImage componentsSeparatedByString: @","];
            if(chunks.count == 1)
            {
                return 120;
            }
            else if (chunks.count >1)
            {
                return 130;
            }
        }
    }
    return 110;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WZFashionNews *fashionsnews = [self.fansionNewsArray objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard  storyboardWithName:@"abalone" bundle:nil];
    WZFansionNewsWebViewController *newWebCtrl = (WZFansionNewsWebViewController *)[storyboard instantiateViewControllerWithIdentifier:@"fashionNewDetail"];
    newWebCtrl.news = fashionsnews;
    [self.navigationController pushViewController:newWebCtrl animated:YES];
}

-(void)loadData
{
    if (!self.fansionNewsArray) {
        self.fansionNewsArray = [NSMutableArray array];
    }else{
        [self.fansionNewsArray removeAllObjects];
    }
    
    NSArray *theFashionNews = [WZFashionNews allObjects];
    
    if (theFashionNews.count) {
        [self.fansionNewsArray addObjectsFromArray:theFashionNews];
        [self sort];
    }else{
        [self.tableView reloadData];
    }
    WZFansionViewController *parent = (WZFansionViewController *)self.parentViewController;
    if (!self.fansionNewsArray.count) {
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
    if (self.selectedIndex == 1) {
        
        [self.tableView reloadData];
    }else{
        [self.tableView reloadData];
    }
    
}

@end