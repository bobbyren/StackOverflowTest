//
//  GPSViewController.m
//  StackOverflowTest
//
//  Created by Bobby Ren on 9/3/14.
//  Copyright (c) 2014 BobbyRen. All rights reserved.
//

#import "GPSViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Polyline+TransformableAttributes.h"
#import "AppDelegate.h"
#import "Polyline+TransformableAttributes.h"

@interface GPSViewController ()

@end

@implementation GPSViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _locationsArray = [NSMutableArray array];
}

-(IBAction)didClickStartGPS:(id)sender {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager startUpdatingLocation];
}

-(IBAction)didClickSaveCoordinates:(id)sender {
    /*
     NSInteger numberOfSteps = _locationsArray.count;
     // you don't need to convert it to a coordinates array.
    CLLocationCoordinate2D coordinates[numberOfSteps];
    for (NSInteger index = 0; index < numberOfSteps; index++) {
        CLLocation *location = [_locationsArray objectAtIndex:index];
        CLLocationCoordinate2D coordinate2 = location.coordinate;
        coordinates[index] = coordinate2;
    }
     */

    // get a reference to the appDelegate so you can access the global managedObjectContext
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

    // creates a new polyline object when app goes into the background, and stores it into core data.
    if (!polyLine) {
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Polyline" inManagedObjectContext:appDelegate.managedObjectContext];
        polyLine = (Polyline *)object;
    }

    [polyLine setCoordinates:_locationsArray];
    NSError *error;
    if ([appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Saved");
    }
    else {
        NSLog(@"Error: %@", error);
    }
}

-(IBAction)didClickLoadCoordinates:(id)sender {
    // get a reference to the appDelegate so you can access the global managedObjectContext
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Polyline"];
    NSError *error;
    id results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];

    if ([results count]) {
        polyLine = (Polyline *)(results[0]);
        NSArray *coordinates = polyLine.coordinates;
        int ct = 0;
        for (CLLocation *loc in coordinates) {
            NSLog(@"location %d: %@", ct++, loc);
        }

        // this copies the array to your mutableArray
        _locationsArray = [coordinates mutableCopy];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations lastObject];
    CLLocationDegrees latitude = currentLocation.coordinate.latitude;
    CLLocationDegrees longitude = currentLocation.coordinate.longitude;
    CLLocationCoordinate2D locationCoordinates = CLLocationCoordinate2DMake(latitude, longitude);

    //store latest location in stored track array;
    [_locationsArray addObject:currentLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
