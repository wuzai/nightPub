//
//  WZMainViewController.m
//  Abalone
//
//  Created by chen  on 13-12-9.
//  Copyright (c) 2013年 曹昊. All rights reserved.
//

#import "WZMainViewController.h"
#import "TSLocateView.h"
#import "WZLocationContrl.h"
#import "WZUser+Networks.h"
#import "WZUser+Me.h"

@interface WZMainViewController ()

@end

@implementation WZMainViewController

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
    
    _currentCityGeocoder = [[CLGeocoder alloc] init];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = 1000.0f;//用来控制定位服务更新频率。单位是“米”
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;//这个属性用来控制定位精度，精度越高耗电量越大。
    [_locationManager startUpdatingLocation];
    
    
    
    NSString *city = [[NSUserDefaults standardUserDefaults] stringForKey:kCity];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:city forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 55, 30);
    button.backgroundColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    button.showsTouchWhenHighlighted = YES;
    [button addTarget:self action:@selector(showLocateView:) forControlEvents:UIControlEventTouchUpInside];


}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    // Failed to receive user's location
    
    NSString *errorMsg = nil;
    if ([error code] == kCLErrorDenied) {
        errorMsg = @"访问被拒绝";
    }
    if ([error code] == kCLErrorLocationUnknown) {
        errorMsg = @"获取位置信息失败";
    }
    NSString *city = [[NSUserDefaults standardUserDefaults] stringForKey:kCity];
        if (city == nil) {
            city = @"北京";
            
            UIBarButtonItem *item = self.navigationItem.rightBarButtonItem;
            UIButton *button=(UIButton *)item.customView;
           [button setTitle:city forState:UIControlStateNormal];
            [[NSUserDefaults standardUserDefaults] setValue:city forKey:kCity];
        }
}



-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [_locationManager stopUpdatingLocation];
    NSString *strLat = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.latitude];
    NSString *strLng = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.longitude];
   
    NSString *locationStr = @"";
    locationStr = [strLng stringByAppendingString:@","];
        locationStr = [locationStr stringByAppendingString:strLat];
    
       [[NSUserDefaults standardUserDefaults] setValue:locationStr forKey:kLocation];
    
    
    NSLog(@"Lat: %@  Lng: %@", strLat, strLng);
    [_currentCityGeocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark* placeMark = [placemarks objectAtIndex:0];
        NSString*  currentCityStr = [placeMark locality];
        NSLog(@"当前省份为：%@",placeMark.administrativeArea);
        NSLog(@"当前城市为：%@",currentCityStr);
        
       if (currentCityStr )
       {
           NSString *city = [[NSUserDefaults standardUserDefaults] stringForKey:kCity];
           if (city == nil) {
               city = currentCityStr;
               UIBarButtonItem *item = self.navigationItem.rightBarButtonItem;
               UIButton *button=(UIButton *)item.customView;
               [button setTitle:city forState:UIControlStateNormal];
               [[NSUserDefaults standardUserDefaults] setValue:city forKey:kCity];
              
           }
       }
    }];
    
}

-(void)location
{
    if (!self.locationManager) {
        self.locationManager = [CLLocationManager new];
    }
    if ([CLLocationManager locationServicesEnabled]) {
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 200.0f;
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        NSString *city = [[NSUserDefaults standardUserDefaults] stringForKey:kCity];
        if (city == nil) {
            city = @"北京";
            UIBarButtonItem *item = self.navigationItem.rightBarButtonItem;
            UIButton *button=(UIButton *)item.customView;
            [button setTitle:city forState:UIControlStateNormal];
        }
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TSLocateView *locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
    //You can uses location to your application.
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
    }
    UIButton *rightButton =(UIButton *)self.navigationItem.rightBarButtonItem.customView;
    [rightButton setTitle:location.city forState:UIControlStateNormal];
    
    [[NSUserDefaults standardUserDefaults] setValue:location.city forKey:kCity];
    
    
    
}

- (IBAction)showLocateView:(id)sender {
    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:@"定位城市" delegate:self];
    [locateView showInView:self.view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
