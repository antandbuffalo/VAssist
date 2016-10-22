//
//  ViewController.m
//  VAssist
//
//  Created by Jeyabalaji T M on 20/10/16.
//  Copyright © 2016 Ant and Buffalo. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"

@interface ViewController () {
    CLBeaconRegion *beaconRegion;
    __weak IBOutlet UILabel *beaconStatus;
    __weak IBOutlet UILabel *doorStatus;
    int counter;
}

@end

@implementation ViewController

-(NSString *)checkDoorStatus {
    //check current door status from local db and return the value
    
    return nil;
}

-(void)sendOpenDoorRequest {
    //send request to RaspberryPi to open the door
    
}

-(void)initBeacon {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    NSString *idString = VA_UUID;
    NSUUID * uuid = [[NSUUID alloc] initWithUUIDString: idString];//[UIDevice currentDevice].identifierForVendor;
    
    beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier: VA_DOOR];
    //[self.locationManager requestAlwaysAuthorization];
    
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    counter = 0;
    [self initBeacon];

}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"something - %@", beacons);
    NSLog(@"region - %@", region);
    CLBeacon *beacon;
    if([region.identifier isEqualToString:VA_DOOR]) {
        if(beacons != nil && beacons.count > 0) {
            [self performSegueWithIdentifier:@"door" sender:self];
            beacon = beacons[0];
            NSString *beaconPlace = @"";
            if(beacon.proximity == CLProximityImmediate) {
                beaconPlace = @"Immediate";
            }
            else if(beacon.proximity == CLProximityNear) {
                beaconPlace = @"Near";
                doorStatus.text = @"You are near a door. Do you want to open the door?";
                if([[self checkDoorStatus] isEqualToString:VA_DOOR_OPENED]) {
                    
                }
                else {
                    
                }
            }
            else if(beacon.proximity == CLProximityFar) {
                beaconPlace = @"Far";
            }
            else {
                beaconPlace = @"Unknown";
            }
            [beaconStatus setText: [NSString stringWithFormat:@"%d - %@", counter++, beaconPlace]];
        }
    }
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
