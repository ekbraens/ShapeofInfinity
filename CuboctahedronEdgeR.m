//
//  CuboctahedronEdgeR.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CuboctahedronEdgeR.h"

@implementation CuboctahedronEdgeR

-(void)shapeMovement
{
    CCActionMoveBy * downRight = [CCActionMoveBy actionWithDuration:0.5 position:ccp(12, -25)];
    CCActionMoveBy * upRight = [CCActionMoveBy actionWithDuration:0.5 position:ccp(12, 25)];
    CCActionMoveBy * upLeft = [CCActionMoveBy actionWithDuration:0.5 position:ccp(-12, 25)];
    CCActionMoveBy * downLeft = [CCActionMoveBy actionWithDuration:0.5 position:ccp(-12, -25)];
    
    CCActionSequence * cuboctahedronEdgeStrafe = [CCActionSequence actions:downRight, upRight, upLeft, downLeft, downLeft, upLeft, upRight, downRight, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:cuboctahedronEdgeStrafe]];
}


@end
