//
//  Polyline+TransformableAttributes.h
//  Test
//
//  Created by Bobby Ren on 8/20/14.
//  Copyright (c) 2014 BobbyRen. All rights reserved.
//

#import "Polyline.h"

@interface Polyline (TransformableAttributes)

#pragma mark transformables

-(NSArray *)coordinates;
-(void)setCoordinates:(id)coordinates;

@end
