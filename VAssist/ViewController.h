//
//  ViewController.h
//  VAssist
//
//  Created by Jeyabalaji T M on 20/10/16.
//  Copyright © 2016 Ant and Buffalo. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface ViewController : UIViewController <CLLocationManagerDelegate>


@property (strong, nonatomic) CLLocationManager *locationManager;

@end

