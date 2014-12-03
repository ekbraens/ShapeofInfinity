//
//  OctahedronEdgeL.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "OctahedronEdgeL.h"

@implementation OctahedronEdgeL

-(void)shapeMovement
{
    CCActionMoveBy * moveLeft = [CCActionMoveBy actionWithDuration:0.40 position:ccp(-25, 0)];
    CCActionMoveBy * moveBottom = [CCActionMoveBy actionWithDuration:0.60 position:ccp(25, -25)];
    CCActionMoveBy * moveUpRight = [CCActionMoveBy actionWithDuration:0.60 position:ccp(25, 25)];
    
    CCActionSequence * octahedronEdgeStrafe = [CCActionSequence actions:moveLeft, moveBottom, moveUpRight, moveLeft, moveLeft, moveUpRight, moveBottom, moveLeft, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:octahedronEdgeStrafe]];
}


@end
