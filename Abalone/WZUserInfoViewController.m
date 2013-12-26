//
//  WZUserInfoViewController.m
//  Abalone
//
//  Created by chen  on 13-12-19.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZUserInfoViewController.h"
#import "WZUser+Me.h"

@interface WZUserInfoViewController ()


@end


@implementation WZUserInfoViewController



#pragma mark tableview delegate and dataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//createWeiboViewController = [[CreateWeiboViewController alloc]init];
//UINavigationController *createWeiboNav=[[UINavigationController alloc]initWithRootViewController:createWeiboViewController];
//createWeiboNav.navigationBar.barStyle = UIBarStyleBlack;
//[self presentViewController:createWeiboNav animated:YES completion:NO];

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if (self.user)
//    {
//        _otherName.text = self.user.email;
//        
//    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
