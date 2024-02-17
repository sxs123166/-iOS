//
//  GTLocation.m
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/2/17.
//

#import "GTLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface GTLocation()<CLLocationManagerDelegate>

@property (nonatomic, strong, readwrite) CLLocationManager *manager;

@end

@implementation GTLocation

+ (GTLocation *)loactionManager {
    static GTLocation *location;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[GTLocation alloc] init];
    });
    return location;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
    }
    return self;
}

- (void)checkLocationAuthorization {
    // 判断系统是否开启
    if(![CLLocationManager locationServicesEnabled]) {
        // 引导弹窗
        
    }
    
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.manager requestWhenInUseAuthorization];
        
    }
}

#pragma mark - delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        //
        [self.manager startUpdatingLocation];
    } else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
    }
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"");
    
    //地理信息
    CLLocation *location = [locations firstObject];
    //
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        // 地标信息
        
    }];
    
    [self.manager stopUpdatingLocation];
}

@end
