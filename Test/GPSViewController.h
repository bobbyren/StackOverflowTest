//
//  GPSViewController.h
//  StackOverflowTest
//
//  Created by Bobby Ren on 9/3/14.
//  Copyright (c) 2014 BobbyRen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Polyline+TransformableAttributes.h"

@interface GPSViewController : UIViewController <CLLocationManagerDelegate>
{
    NSMutableArray *_locationsArray;
    Polyline *polyLine;
    CLLocationManager *locationManager;
}

-(IBAction)didClickStartGPS:(id)sender;
-(IBAction)didClickSaveCoordinates:(id)sender;
-(IBAction)didClickLoadCoordinates:(id)sender;
@end
