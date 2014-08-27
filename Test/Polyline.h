//
//  Polyline.h
//  Test
//
//  Created by Bobby Ren on 8/20/14.
//  Copyright (c) 2014 BobbyRen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Polyline : NSManagedObject

@property (nonatomic, retain) id coordinates;
@property (nonatomic, retain) NSData * coordinates_data;

@end
