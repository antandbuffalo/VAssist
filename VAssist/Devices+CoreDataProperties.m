//
//  Devices+CoreDataProperties.m
//  VAssist
//
//  Created by Jeyabalaji T M on 13/11/16.
//  Copyright © 2016 Ant and Buffalo. All rights reserved.
//

#import "Devices+CoreDataProperties.h"

@implementation Devices (CoreDataProperties)

+ (NSFetchRequest<Devices *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Devices"];
}

@dynamic ble_distance;
@dynamic ble_id;
@dynamic p_desc;
@dynamic p_id;
@dynamic p_status;
@dynamic messages;

@end
