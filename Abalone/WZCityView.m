//
//  WZCityView.m
//  Abalone
//
//  Created by 陈 海涛 on 13-9-16.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZCityView.h"
#import "WZStoresViewController.h"
#import "JWFolders.h"

@implementation WZCityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"CityView" owner:self options:nil] lastObject];
        [self addSubview:view];
        self.frame = view.frame;
        
      NSString *type =  [[NSUserDefaults standardUserDefaults] stringForKey:kType];
        if (type == nil) {
            type = @"全部";
        }
        for (UIButton *button in self.types) {
            if ([button.titleLabel.text isEqualToString:type]) {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            [button addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
            button.showsTouchWhenHighlighted = YES;
        }
        
    }
    return self;
}

- (void)selectType:(UIButton *)button
{
    [[NSUserDefaults standardUserDefaults] setValue:button.titleLabel.text forKey:kType];
    NSString *type =  button.titleLabel.text;
    for (UIButton *button in self.types) {
        if ([button.titleLabel.text isEqualToString:type]) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
       
    }
[self.sVC.floder closeCurrentFolder];
    UIButton *rightButton =(UIButton *)self.sVC.navigationItem.rightBarButtonItem.customView;
[rightButton setTitle:type forState:UIControlStateNormal];

[WZMerchant fetchMerchantList];

}

@end
