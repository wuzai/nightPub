//
//  WZFinderViewController.h
//  Abalone
//
//  Created by chen  on 13-11-21.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import <CoreLocation/CoreLocation.h>

@interface WZFinderViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>


@property (strong, nonatomic) IBOutlet UITableView *usersTableView;
@property (strong, nonatomic) IBOutlet UITextField *findTextField;
@property (nonatomic,strong) NSMutableArray *users;
@property (strong, nonatomic) IBOutlet UIButton *findbutton;
- (IBAction)findByName:(id)sender;
@property (strong,nonatomic) UIControl *searchBg;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end
