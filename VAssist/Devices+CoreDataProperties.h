//
//  Devices+CoreDataProperties.h
//  VAssist
//
//  Created by Jeyabalaji T M on 13/11/16.
//  Copyright © 2016 Ant and Buffalo. All rights reserved.
//

#import "Devices+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Devices (CoreDataProperties)

+ (NSFetchRequest<Devices *> *)fetchRequest;

@property (nonatomic) int16_t ble_distance;
@property (nullable, nonatomic, copy) NSString *ble_id;
@property (nullable, nonatomic, copy) NSString *p_desc;
@property (nullable, nonatomic, copy) NSString *p_id;
@property (nullable, nonatomic, copy) NSString *p_status;
@property (nullable, nonatomic, retain) Messages *messages;

@end

NS_ASSUME_NONNULL_END
