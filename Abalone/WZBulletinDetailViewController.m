//
//  WZBulletinDetailViewController.m
//  Abalone
//
//  Created by chen  on 13-11-27.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZBulletinDetailViewController.h"
#import "WZFollowCell.h"
#import "WZFollowBulltin+Mapping.m"
#import "WZAddFollowBulletinViewController.h"

@interface WZBulletinDetailViewController ()

@end

@implementation WZBulletinDetailViewController
@synthesize bulletin=_bulletin;
@synthesize followBulletinArray=_followBulletinArray;

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
    if(!self.bulletin)
    {
        self.followBulletinArray =(NSMutableArray *)[WZFollowBulltin allObjects ];
    }
    else
    {
        self.followBulletinArray = [NSMutableArray new];
        [self.followBulletinArray addObjectsFromArray:[self.bulletin.followBulletins allObjects]];
        NSLog(@"count=%i",self.followBulletinArray.count);
        
        [self.followBulletinArray sortUsingComparator:^(WZFollowBulltin *s1, WZFollowBulltin  *s2){
                    
            return [s1.createAt compare:s2.createAt];
        }];
        [self.tableView reloadData ];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    // Return the number of rows in the section.
    return self.followBulletinArray.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = ((WZBulletin *)[self.followBulletinArray objectAtIndex:indexPath.row]).content;
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240, 999999) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    return size.height + 50 > 70? size.height + 50 : 70;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"followBulletinsCell";
    WZFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    WZFollowBulltin *bulletin = [self.followBulletinArray objectAtIndex:indexPath.row];
    CGSize size = [bulletin.content sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240, 999999) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect frame = cell.contentText.frame;
    frame.size.height = size.height ;
    cell.contentText.frame = frame;
    
    CGRect contentFrame = cell.contentView.frame;
    contentFrame.size.height  = size.height + 50 > 70? size.height + 50 : 70;

    cell.contentView.frame = contentFrame;
    
    if (bulletin.user.faceIcon)
    {
         cell.faceIconView.imageURL = [NSURL URLWithString: bulletin.user.faceIcon];
    }
    else
    {
        cell.faceIconView.image = [UIImage imageNamed:@"defAvatar.png"];
    }
    

   
    
    cell.contentText.text = bulletin.content;
    cell.userNameLabel.text = bulletin.user.username;
    
    //如何换行
    // Configure the cell...
    
    return cell;
}

//
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"sendFollowBulletin"]) {
       
        if ([segue.destinationViewController isKindOfClass:[WZAddFollowBulletinViewController class]]) {
            WZAddFollowBulletinViewController *addFollowBulletinViewController = (WZAddFollowBulletinViewController *)segue.destinationViewController;
            addFollowBulletinViewController.bulletin = self.bulletin;
        }
    }
}
@end
