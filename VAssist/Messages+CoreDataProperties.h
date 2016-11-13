//
//  Messages+CoreDataProperties.h
//  VAssist
//
//  Created by Jeyabalaji T M on 13/11/16.
//  Copyright © 2016 Ant and Buffalo. All rights reserved.
//

#import "Messages+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Messages (CoreDataProperties)

+ (NSFetchRequest<Messages *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *desc;
@property (nonatomic) int16_t m_id;
@property (nullable, nonatomic, copy) NSString *p_id;
@property (nullable, nonatomic, copy) NSString *p_status;

@end

NS_ASSUME_NONNULL_END
