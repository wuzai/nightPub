//
//  WZFansionNewsWebViewController.m
//  Abalone
//
//  Created by chen  on 13-12-2.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZFansionNewsWebViewController.h"

@interface WZFansionNewsWebViewController ()

@end

@implementation WZFansionNewsWebViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [self.webView loadHTMLString:self.news.content baseURL:[NSBundle mainBundle].bundleURL];
}

@end
