//
//  TetrahedronEdgeL.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "TetrahedronEdgeL.h"

@implementation TetrahedronEdgeL

-(void)shapeMovement
{
    CCActionMoveBy * moveDown = [CCActionMoveBy actionWithDuration:1 position:ccp(0, -50)];
    CCActionMoveBy * moveRight = [CCActionMoveBy actionWithDuration:1 position:ccp(50, 0)];
    CCActionMoveBy * moveUp = [CCActionMoveBy actionWithDuration:1 position:ccp(0, 50)];
    CCActionMoveBy * moveLeft = [CCActionMoveBy actionWithDuration:1 position:ccp(-50, 0)];
    
    CCActionSequence * tetrahedronEdgeStrafe = [CCActionSequence actions:moveLeft, moveDown, moveRight, moveUp, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:tetrahedronEdgeStrafe]];
}

@end
