//
//  WZCityView.h
//  Abalone
//
//  Created by 陈 海涛 on 13-9-16.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZMerchant+Networks.h"
@class  WZStoresViewController;

@interface WZCityView : UIView



@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *types;
@property (strong,nonatomic) WZStoresViewController *sVC;
@end
