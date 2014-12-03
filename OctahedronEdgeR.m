//
//  OctahedronEdgeR.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "OctahedronEdgeR.h"

@implementation OctahedronEdgeR

-(void)shapeMovement
{
    CCActionMoveBy * moveRight = [CCActionMoveBy actionWithDuration:0.40 position:ccp(25, 0)];
    CCActionMoveBy * moveUpLeft = [CCActionMoveBy actionWithDuration:0.60 position:ccp(-25, 25)];
    CCActionMoveBy * moveTopCenter = [CCActionMoveBy actionWithDuration:0.60 position:ccp(-25, 25)];
    CCActionMoveBy * moveDownLeft = [CCActionMoveBy actionWithDuration:0.60 position:ccp(-25, -25)];
    
    CCActionSequence * octahedronEdgeStrafe = [CCActionSequence actions:moveRight, moveDownLeft, moveUpLeft, moveRight, moveRight, moveTopCenter, moveDownLeft, moveRight, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:octahedronEdgeStrafe]];
}


@end
