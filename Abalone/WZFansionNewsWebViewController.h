//
//  WZFansionNewsWebViewController.h
//  Abalone
//
//  Created by chen  on 13-12-2.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZFashionNews.h"

@interface WZFansionNewsWebViewController : UIViewController
@property (strong, nonatomic) IBOutlet WZFashionNews *news;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
