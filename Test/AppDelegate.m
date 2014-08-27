//
//  AppDelegate.m
//  Test
//
//  Created by Bobby Ren on 7/18/14.
//  Copyright (c) 2014 BobbyRen. All rights reserved.
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Polyline+TransformableAttributes.h"
#import <CoreLocation/CoreLocation.h>

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

    // creates a new polyline object when app goes into the background, and stores it into core data.
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Polyline" inManagedObjectContext:self.managedObjectContext];
    Polyline *polyline = (Polyline *)object;

    CLLocation *location = [[CLLocation alloc] initWithLatitude:37.765 longitude:-122.419];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:37.7683 longitude:-122.4200];
    CLLocation *location3 = [[CLLocation alloc] initWithLatitude:37.754 longitude:-122.4109];
    [polyline setCoordinates:@[location, location2, location3]];
    NSError *error;
    if ([self.managedObjectContext save:&error]) {
        NSLog(@"Saved");
    }
    else {
        NSLog(@"Error: %@", error);
    }

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    /*
    UILocalNotification *warning = [[UILocalNotification alloc] init];
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        // this is the first time we received this so increment the badge number
        warning.soundName = UILocalNotificationDefaultSoundName;
        warning.applicationIconBadgeNumber = 1;
    }

    warning.alertBody = @"Test";
    warning.userInfo = @{@"notificationName":@"myLocalNotification"};
    [[UIApplication sharedApplication] presentLocalNotificationNow:warning];
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Polyline"];
    NSError *error;
    id results = [self.managedObjectContext executeFetchRequest:request error:&error];

    if ([results count]) {
        Polyline *polyline = (Polyline *)(results[0]);
        NSArray *coordinates = polyline.coordinates;
        int ct = 0;
        for (CLLocation *loc in coordinates) {
            NSLog(@"location %d: %@", ct++, loc);
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"Local notification received: %@", notification.alertBody);
    if ([notification.userInfo[@"notificationName"] isEqualToString:@"myLocalNotification"]) {
        [self.window.rootViewController performSegueWithIdentifier:@"MainToNotification" sender:nil];
    }
}

#pragma mark CoreData
- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    else {
        NSLog(@"Error no persistent store");
    }

    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];

    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"test.sqlite"]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }

    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
