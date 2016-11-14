//
//  ViewController.m
//  VAssist
//
//  Created by Jeyabalaji T M on 20/10/16.
//  Copyright © 2016 Ant and Buffalo. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "ObjectViewController.h"
#import "Devices+CoreDataProperties.h"
#import "Utility.h"

@interface ViewController () {
    CLBeaconRegion *beaconRegion;
    __weak IBOutlet UILabel *beaconStatus;
    __weak IBOutlet UILabel *doorStatus;
    int counter;
    NSMutableArray *devices;
    BOOL isModalPresented;
    ObjectViewController *objectVC;
}

@end

@implementation ViewController
- (IBAction)testButtonAction:(UIButton *)sender {
    [self presentObjectDetectedVC: @"test"];
}

-(NSString *)checkDoorStatus:(NSString *)deviceName {
    //check current door status from local db and return the value
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"p_id == %@", deviceName];
    NSMutableArray *records = [Utility recordsForThePredicate:predicate forTable:@"Devices"];
    if(records.count > 0) {
        Devices *device = [records objectAtIndex:0];
        NSLog(@"sta - %@", device.p_status);
    }
    return nil;
}

-(void)sendOpenDoorRequest {
    //send request to RaspberryPi to open the door
    
}

-(void)initBeacon {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    NSString *idString = VA_UUID;
    //same UUID can be used for multiple beacons. The proximity id can be used to identify them uniquely. One location can have one UUID and multiple beacons
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

    [Utility initDatabase];
    isModalPresented = NO;
    
    counter = 0;
    [self initBeacon];
    [self checkDoorStatus:VA_DOOR];
}

-(void)presentObjectDetectedVC:(NSString *)message {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    objectVC = (ObjectViewController *)[storyboard instantiateViewControllerWithIdentifier:@"objectVC"];
    objectVC.modalPresentationStyle = UIModalPresentationFullScreen;
    objectVC.vcTitle = @"My Title";
    objectVC.message = message;
    
    isModalPresented = YES;
    [self.navigationController presentViewController:objectVC animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"something - %@", beacons);
    NSLog(@"region - %@", region);
    CLBeacon *beacon;
    if([region.identifier isEqualToString:VA_DOOR]) {
        if(beacons != nil && beacons.count > 0) {
            
            //[self presentObjectDetectedVC];
            
            beacon = beacons[0];
            NSString *beaconPlace = @"";
            BOOL closeModal = YES;
            NSString *message = @"";
            
            if(beacon.proximity == CLProximityImmediate) {
                beaconPlace = @"Immediate";
            }
            else if(beacon.proximity == CLProximityNear) {
                beaconPlace = @"Near";
                doorStatus.text = @"You are near a door. Do you want to open the door?";
                if([[self checkDoorStatus: VA_DOOR] isEqualToString:VA_DOOR_CLOSED]) {
                    //open the door
                    message = @"The door is closed. Do you want to open the door?";
                }
                else {
                    //close the door
                    message = @"The door is opened. Do you want to close the door?";
                }
                closeModal = NO;
            }
            else if(beacon.proximity == CLProximityFar) {
                beaconPlace = @"Far";
            }
            else {
                beaconPlace = @"Unknown";
            }
            if(closeModal) {
                if(objectVC != nil && isModalPresented) {
                    [objectVC dismissViewControllerAnimated:YES completion:nil];
                }
            }
            else {
                if(!isModalPresented) {
                    [self presentObjectDetectedVC: message];
                }
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
