//
//  CuboctahedronEdgeL.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CuboctahedronEdgeL.h"

@implementation CuboctahedronEdgeL

-(void)shapeMovement
{
    CCActionMoveBy * moveLeft = [CCActionMoveBy actionWithDuration:0.30 position:ccp(-8, 0)];
    CCActionMoveBy * downLeft = [CCActionMoveBy actionWithDuration:0.70 position:ccp(-16, -24)];
    CCActionMoveBy * downRight = [CCActionMoveBy actionWithDuration:0.70 position:ccp(16, -24)];
    CCActionMoveBy * moveRight = [CCActionMoveBy actionWithDuration:0.70 position:ccp(16, 0)];
    CCActionMoveBy * upRight = [CCActionMoveBy actionWithDuration:0.60 position:ccp(16, 24)];
    CCActionMoveBy * upLeft = [CCActionMoveBy actionWithDuration:0.70 position:ccp(-16, 24)];
    
    CCActionSequence * cuboctahedronEdgeStrafe = [CCActionSequence actions:moveLeft, downLeft, downRight, moveRight, upRight, upLeft, moveLeft, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:cuboctahedronEdgeStrafe]];
}

@end
