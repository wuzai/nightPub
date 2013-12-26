//
//  WZServiceItemListViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-23.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZServiceItemListViewController.h"
#import "WZServiceItem.h"
#import "WZStore+serviceItems.h"
#import <RestKit/RestKit.h>
#import "WZServiceItemCell.h"
#import "WZProduct+Networks.h"
#import "WZMerchant.h"
#import "WZProduct.h"

@interface WZServiceItemListViewController ()

@end

static NSString *const cellIdentifier = @"serviceItemCell";
@implementation WZServiceItemListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    [self.tableView setBackgroundColor:[UIColor clearColor] ];
    NSBundle *classBundle = [NSBundle bundleForClass:[WZServiceItemCell class]];
    UINib *nib = [UINib nibWithNibName:@"serviceItemCell" bundle:classBundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[WZProduct fetchProducts:self.store.merchant.gid];
    //[self loadData];
    
}

-(void)fetchServiceSuccess:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZProductsGetSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZProductsGetFailedNotification object:nil];
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    //[self loadData];
}

-(void)fetchServiceFail:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZProductsGetSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WZProductsGetFailedNotification object:nil];
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
}
//
//-(void)loadData
//{
//    if (!self.serviceItems) {
//        self.serviceItems = [NSMutableArray new];
//        
//    }else{
//        [self.serviceItems removeAllObjects];
//    }
////    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"WZProduct"];
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"merchantId = %@",self.store.merchant.gid];
////    request.predicate = predicate;
//    
//    NSArray  *products =[WZProduct allObjects];
//    
//    [self.serviceItems addObjectsFromArray:products];
//    [self.tableView reloadData];
//}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchServiceSuccess:) name:WZProductsGetSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchServiceFail:) name:WZProductsGetFailedNotification object:nil];

    [WZProduct fetchProducts:self.merchant.gid];
    [self updateViews];
}

-(void)updateViews
{
    NSArray *products=    [self.merchant.products allObjects];
    
    if (!self.serviceItems) {
               self.serviceItems = [NSMutableArray new];
        
           }else{
               [self.serviceItems removeAllObjects];
            }
    [self.serviceItems addObjectsFromArray:products];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int itemCount = self.serviceItems.count;
   
    return itemCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[WZServiceItemCell class]]) {
        //如果不能够实现刷新，显示时先判断服务是否可用。需要提供接口。
        WZProduct *serviceItem = [self.serviceItems objectAtIndex:indexPath.row];
        
            WZServiceItemCell *serviceItemCell = (WZServiceItemCell *)cell;
//            serviceItemCell.serviceItemImage.imageURL = [NSURL URLWithString:serviceItem.postImage];
        
        //需要修改接口地
        serviceItemCell.serviceItemImage.imageURL = [NSURL URLWithString:serviceItem.postImage];
        
            serviceItemCell.serviceItemTitle.text = serviceItem.name;
            serviceItemCell.serviceItemContent.lineBreakMode = NSLineBreakByTruncatingTail;
            serviceItemCell.serviceItemContent.numberOfLines = 0;
            serviceItemCell.serviceItemContent.text = serviceItem.intrl;
       
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.parentViewController performSegueWithIdentifier:@"showServiceItemInfo" sender:[self.serviceItems objectAtIndex:indexPath.row]];
}



@end
