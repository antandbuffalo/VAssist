//
//  Messages+CoreDataProperties.m
//  VAssist
//
//  Created by Jeyabalaji T M on 13/11/16.
//  Copyright © 2016 Ant and Buffalo. All rights reserved.
//

#import "Messages+CoreDataProperties.h"

@implementation Messages (CoreDataProperties)

+ (NSFetchRequest<Messages *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Messages"];
}

@dynamic desc;
@dynamic m_id;
@dynamic p_id;
@dynamic p_status;

@end
