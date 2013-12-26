//
//  WZFinderViewController.m
//  Abalone
//
//  Created by chen  on 13-11-21.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZFinderViewController.h"
#import "WZUser+Me.h"
#import "WZUserListCell.h"
#import <RestKit/RestKit.h>
#import "WZUser+Networks.h"
#import "WZUserInfosViewController.h"
#import "WZUser+Networks.h"
#import "WZUser.h"

@interface WZFinderViewController ()
{
    NSMutableArray *_usersByName;
}

-(void )reload;
-(void)findUserByName:(NSString *)name;

@end
@implementation WZFinderViewController

@synthesize usersTableView = _usersTableView;

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
    
    [[WZUser me] findAllUsers];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadUsersSuccess:) name:WZUserProfileGetSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadUsersFail:) name:WZUserProfileGetFailedNotification object:nil];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = NO;
    //[self.searchBar.keyboardType setReturnKeyType:UIReturnKeyDone];
    
    [self reload];
}

-(void)downloadUsersSuccess:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileGetSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileGetFailedNotification object:nil];
    [self reload ];
    [_usersTableView reloadData];
}

-(void)downloadUsersFail:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileGetSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZUserProfileGetFailedNotification object:nil];
}



-(void)reload
{
    //查询所有的用户
    
    
    if (!_users) {
        _users = [NSMutableArray new];
    }
    [_users removeAllObjects];
    
    
    _users = [NSMutableArray arrayWithArray:[WZUser allObjects]];
    [_users removeObject:[WZUser me]];
    [_usersTableView reloadData];
   
}







-(NSInteger)tableView:(UITableView *)tableView
     numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = [_users count];
    return number;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FirstLevelCell = @"userIdentifier";
    
    
    WZUser *user = [_users objectAtIndex:indexPath.row];
    WZUserListCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    
    
    
    cell.titleLabel.text = user.username;
    cell.realNameLabel.text = user.email;
    if (user.faceIcon)
    {
        cell.faceIconView.imageURL = [NSURL URLWithString:user.faceIcon];
    }
    else
    {
        cell.faceIconView.image = [UIImage imageNamed:@"defAvatar.png"];
    }
    
 
   NSString *location = [[NSUserDefaults standardUserDefaults] objectForKey:kLocation];
    NSArray *userArray = [location componentsSeparatedByString:@","];
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:[userArray[0] doubleValue] longitude:[userArray[1] doubleValue]];
    
    NSString *locationStr = user.location;
    NSArray *s1Array = [locationStr componentsSeparatedByString:@","];
    CLLocation *l1 = [[CLLocation alloc] initWithLatitude:[s1Array[0] doubleValue] longitude:[s1Array[1] doubleValue]];

    cell.location.text = [NSString stringWithFormat:@"%0.3fKM",[userLocation distanceFromLocation:l1]/1000];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"abalone" bundle:nil];
    WZUserInfosViewController *infoViewControll = (WZUserInfosViewController *)[sb instantiateViewControllerWithIdentifier:@"userInfo"];
     WZUser *user = [_users objectAtIndex:indexPath.row];
    infoViewControll.user = user;
    [self.navigationController pushViewController:infoViewControll animated:YES];
}

-(void)sortWithLocation
{
    WZUser *user = [WZUser me];
    NSString *userLoc = user.location;
    NSArray *userArray = [userLoc componentsSeparatedByString:@","];
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:[userArray[0] doubleValue] longitude:[userArray[1] doubleValue]];
    [self.users sortUsingComparator:^(WZUser *s1, WZUser *s2)
     {
         
         NSString *locationStr = s1.location;
         NSString *locationStr2 = s2.location;
         NSArray *s1Array = [locationStr componentsSeparatedByString:@","];
         NSArray *s2Array = [locationStr2 componentsSeparatedByString:@","];
         CLLocation *l1 = [[CLLocation alloc] initWithLatitude:[s1Array[0] doubleValue] longitude:[s1Array[1] doubleValue]];
         CLLocation *l2 = [[CLLocation alloc] initWithLatitude:[s2Array[0] doubleValue] longitude:[s2Array[1] doubleValue]];
         
         
         return [[NSNumber numberWithDouble:[userLocation distanceFromLocation:l1]] compare: [NSNumber numberWithDouble: [userLocation distanceFromLocation:l2]]] ;

     }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//当你希望选中UISearchBar的时候，键盘自动调用加载到界面，你需要将下面函数的返回值设置为YES
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
     self.searchBg = [[UIControl alloc] initWithFrame:CGRectMake(0, 45, 320, 240)];
    [self.searchBg addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchBg];
    return YES;
    
}

- (IBAction)backgroundTap:(id)sender {
    [self.searchBar resignFirstResponder];
    if (self.searchBg ) {
        [self.searchBg removeFromSuperview];
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //[self.searchBar r];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    if (self.searchBg) {
        [self.searchBg removeFromSuperview];
    }

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self findByName:searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"cancle clicked");
    _searchBar.text = @"";
   [_searchBar resignFirstResponder];
    
}

- (IBAction)findByName:(id)sender {
    //[WZUser ]
    [self.searchBar resignFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadUsersSuccess:) name:WZUserProfileGetSucceedNotification  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadUsersFail:) name:WZUserProfileGetFailedNotification  object:nil];

    //先清除本地缓存中的user信息
    
    
    [_users makeObjectsPerformSelector:@selector(deleteEntity)];
    [[RKObjectManager sharedManager].objectStore save:nil];

    
    
    
    //[[RKObjectManager sharedManager].objectStore save:nil];

    if (self.searchBar.text )
    {
        if ([WZUser me])
        {
        [[WZUser me]findUsersByname:self.searchBar.text];
        }
    }
    
}
@end
