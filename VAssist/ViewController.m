//
//  ViewController.m
//  VAssist
//
//  Created by Jeyabalaji T M on 20/10/16.
//  Copyright © 2016 Ant and Buffalo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CLBeaconRegion *beaconRegion;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    NSString *idString = @"8AEFB031-6C32-486F-825B-E26FA193487D";
    NSUUID * uuid = [[NSUUID alloc] initWithUUIDString: idString];//[UIDevice currentDevice].identifierForVendor;

    beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"test"];
    //[self.locationManager requestAlwaysAuthorization];
    
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];

}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"something - %@", beacons);
}

-(void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    NSLog(@"Error %@", error);
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"Error %@", error);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error %@", error);
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"did enter - %@", region);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
