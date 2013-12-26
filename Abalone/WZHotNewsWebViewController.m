//
//  WZHotNewsWebViewController.m
//  Abalone
//
//  Created by chen  on 13-12-2.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZHotNewsWebViewController.h"
@interface WZHotNewsWebViewController ()

@end

@implementation WZHotNewsWebViewController

@synthesize news=_news;
@synthesize webView=_webView;

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


- (void)viewWillAppear:(BOOL)animated
{
    self.newsTitle.text = self.news.title;
    self.source.text = self.news.source;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    self.newsDate.text = [dateFormatter stringFromDate:self.news.createAt];
    
        
    
    
    [self.webView loadHTMLString:self.news.content baseURL:[NSBundle mainBundle].bundleURL];
}

@end
