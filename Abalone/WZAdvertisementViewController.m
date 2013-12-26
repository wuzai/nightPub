//
//  WZAdvertisementViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-27.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZAdvertisementViewController.h"
#import "WZAd.h"
#import "WZShowServiceItemDetailViewController.h"
#import "WZMerchant.h"

@interface WZAdvertisementViewController ()
{
    IBOutlet UIWebView *webView;
    UIBarButtonItem *_extendItem;
}
@end

@implementation WZAdvertisementViewController
@synthesize advertisement = _advertisement;
@synthesize adTitle =_adTitle;

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
    _extendItem = self.navigationItem.rightBarButtonItem;
   
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    _adTitle.text = _advertisement.title;
    _merchantNameLabel.text = _advertisement.merchant.name;
    _dateLabel.text = _advertisement.merchant.createTime;
    self.navigationItem.rightBarButtonItem = _advertisement.serviceItem?_extendItem:nil;
    [webView loadHTMLString:_advertisement.content baseURL:[NSBundle mainBundle].bundleURL];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Service"]) {
        WZShowServiceItemDetailViewController *dest = segue.destinationViewController;
        dest.serviceItem = _advertisement.serviceItem;
    }
}
@end
