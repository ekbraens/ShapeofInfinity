//
//  TetrahedronFaceR.m
//  mgwuEricBraen
//
//  Created by New on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "TetrahedronFaceR.h"

@implementation TetrahedronFaceR

-(void)shapeMovement
{
    CCActionMoveBy * moveDown = [CCActionMoveBy actionWithDuration:0.67 position:ccp(0, -25)];
    CCActionMoveBy * downRight = [CCActionMoveBy actionWithDuration:0.67 position:ccp(25, -25)];
    CCActionMoveBy * upLeft = [CCActionMoveBy actionWithDuration:0.67 position:ccp(-25, 25)];
    CCActionMoveBy * downLeft = [CCActionMoveBy actionWithDuration:0.67 position:ccp(-25, -25)];
    CCActionMoveBy * upRight = [CCActionMoveBy actionWithDuration:0.67 position:ccp(25, 25)];
    CCActionMoveBy * moveUp = [CCActionMoveBy actionWithDuration:0.67 position:ccp(0, 25)];
    
    CCActionSequence * gyrobifastigiumStrafe = [CCActionSequence actions:moveDown, downRight, upLeft, downLeft, upRight, moveUp, nil];
    
    [self runAction:[CCActionRepeatForever actionWithAction:gyrobifastigiumStrafe]];
}

@end
