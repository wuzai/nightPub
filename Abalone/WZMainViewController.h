//
//  WZMainViewController.h
//  Abalone
//
//  Created by chen  on 13-12-9.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WZMainViewController : UIViewController<UIActionSheetDelegate,CLLocationManagerDelegate>
{
    CLLocationManager* _locationManager;
    
    CLGeocoder*  _currentCityGeocoder;
}
@property (nonatomic,strong) CLLocationManager *locationManager;
@end
