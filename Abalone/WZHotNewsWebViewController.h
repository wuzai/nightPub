//
//  WZHotNewsWebViewController.h
//  Abalone
//
//  Created by chen  on 13-12-2.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZHotNews.h"

@interface WZHotNewsWebViewController : UIViewController

@property (strong, nonatomic) IBOutlet WZHotNews *news;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsDate;
@property (weak, nonatomic) IBOutlet UILabel *source;

@end
