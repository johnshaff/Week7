//
//  AppDelegate.h
//  CoreDataHotelService
//
//  Created by Adam Wallraff on 11/28/16.
//  Copyright © 2016 Adam Wallraff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

