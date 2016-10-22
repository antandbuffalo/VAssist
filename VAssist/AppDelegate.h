//
//  AppDelegate.h
//  VAssist
//
//  Created by Jeyabalaji T M on 20/10/16.
//  Copyright © 2016 Ant and Buffalo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

