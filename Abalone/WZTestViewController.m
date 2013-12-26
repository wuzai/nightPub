//
//  WZTestViewController.m
//  Abalone
//
//  Created by chen  on 13-11-20.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZTestViewController.h"

@interface WZTestViewController ()


@end


@implementation WZTestViewController

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
    UITableView *tview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-300) style:UITableViewStyleGrouped];
    [tview setDelegate:self];
    [tview setDataSource:self];
    [self.view addSubview:tview];	// Do any additional setup after loading the view.
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0||section == 3) {
        return 2;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int section = indexPath.section;
    int row = indexPath.row;
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (section) {
            case 0:
                if(row == 0)
                {
                    cell.textLabel.text =  @"个人资料";
                }else{
                    cell.textLabel.text =  @"账号设置";
                }
                break;
            case 1:
                cell.textLabel.text =  @"消息设置";
                break;
            case 2:
                cell.textLabel.text =  @"隐私设置设置";
                break;
            case 3:
                if(row == 0)
                {
                    cell.textLabel.text =  @"关于产品";
                }else{
                    cell.textLabel.text =  @"检查新版本";
                }
                break;
            default:
                break;
        }
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
