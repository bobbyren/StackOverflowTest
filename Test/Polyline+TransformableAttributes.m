//
//  Polyline+TransformableAttributes.m
//  Test
//
//  Created by Bobby Ren on 8/20/14.
//  Copyright (c) 2014 BobbyRen. All rights reserved.
//

#import "Polyline+TransformableAttributes.h"

@implementation Polyline (TransformableAttributes)

#pragma mark Transformables
-(NSArray *)coordinates {
    if (!self.coordinates_data)
        return nil;

    return [NSKeyedUnarchiver unarchiveObjectWithData:self.coordinates_data];
}

-(void)setCoordinates:(id)coordinates {
    NSData *coordinates_data = [NSKeyedArchiver archivedDataWithRootObject:coordinates];
    [self setValue:coordinates_data forKey:@"coordinates_data"];
}

@end
